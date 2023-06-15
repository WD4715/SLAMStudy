#include <iostream>
#include <vector>
#include <Eigen/Core>

#include <pangolin/pangolin.h>
#include <opencv2/opencv.hpp>
#include<unistd.h>

using namespace std;
using namespace Eigen;
void showPointcloud(
    const vector<Vector4d, Eigen::aligned_allocator<Vector4d>> &pointcloud);
int main(int argc, char **argv){
    
    // 1. camera intrinsic
    double fx=718.856, fy=718.856, cx=607.1928, cy=185.2157;
    double b=0.573;

    cv::Mat left=cv::imread("../data/left.png", cv::IMREAD_COLOR);
    cv::Mat right=cv::imread("../data/right.png", cv::IMREAD_COLOR);


    // 2. Depth 
    cv::Ptr<cv::StereoSGBM> sgbm=cv::StereoSGBM::create(
        0, 96, 9, 8 * 9 * 9, 32 * 9 * 9, 1, 63, 10, 100, 3
    );

    cv::Mat disparity_sgbm, disparity;
    sgbm->compute(left, right, disparity_sgbm);
    disparity_sgbm.convertTo(disparity, CV_32F, 1./16.f);


    // 3. 3D Reconstruction
    vector<Vector4d, Eigen::aligned_allocator<Vector4d>> pointcloud;

    for (int v=0; v < left.rows; v++){
        for (int u=0; u < left.cols; u++){
            if (disparity.at<float>(v, u) <= 0. || disparity.at<float>(v, u) >= 96.){

                Vector4d point(0, 0, 0, left.at<uchar>(v, u) / 255.0);

                double x = (u -cx)/fx;
                double y = (v -cy)/fy;
                double depth = fx*b/(disparity.at<float>(v, u));

                point[0]=x*depth;
                point[1]=y*depth;
                point[2]=depth;
                pointcloud.push_back(point);

            }
        }
    }
    showPointcloud(pointcloud);
    return 0;
}

void showPointcloud(const vector<Vector4d, Eigen::aligned_allocator<Vector4d>> &pointcloud){
    pangolin::CreateWindowAndBind("Point Cloud Viewer", 1024, 768);
    glEnable(GL_DEPTH_TEST);
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    pangolin::OpenGlRenderState s_cam(
    pangolin::ProjectionMatrix(1024, 768, 500, 500, 512, 389, 0.1, 1000),
    pangolin::ModelViewLookAt(0, -0.1, -1.8, 0, 0, 0, 0.0, -1.0, 0.0)
    );
    pangolin::View &d_cam = pangolin::CreateDisplay()
        .SetBounds(0.0, 1.0, pangolin::Attach::Pix(175), 1.0, -1024.0f / 768.0f)
        .SetHandler(new pangolin::Handler3D(s_cam));

    while (pangolin::ShouldQuit() == false) {
        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

        d_cam.Activate(s_cam);
        glClearColor(1.0f, 1.0f, 1.0f, 1.0f);

        glPointSize(2);
        glBegin(GL_POINTS);
        for (auto &p: pointcloud) {
            glColor3f(p[3], p[3], p[3]);
            glVertex3d(p[0], p[1], p[2]);
        }
        glEnd();
        pangolin::FinishFrame();
        usleep(5000);   // sleep 5 ms
    }
    return;
}
