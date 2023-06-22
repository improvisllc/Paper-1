// CFDResultAnalyzer.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <algorithm>
#include <filesystem>
#include <fstream>
#include <iostream>
#include <map>
#include <string>
#include <vector>

#include "json.hpp"

namespace fs = std::filesystem;
using json = nlohmann::json;

struct SessionDataAndResults {
    int fluidCells;
    int contactCells;
    double density;
    double densityProgress;
    double velocity;
    double velocityProgress;
    double drag;
    double dragProgress;
    double lift;
    double liftProgress;
    double side;
    double sideProgress;
    double roll;
    double rollProgress;
    double pitch;
    double pitchProgress;
    double yaw;
    double yawProgress;
    double cD;
    double cDProgress;
    double cL;
    double cLProgress;
};

bool is_number(const std::string& s)
{
    return !s.empty() && std::find_if(s.begin(),
        s.end(), [](unsigned char c) { return !std::isdigit(c); }) == s.end();
}

bool copyFile(const char* SRC, const char* DEST)
{
    std::ifstream src(SRC, std::ios::binary);
    std::ofstream dest(DEST, std::ios::binary);
    dest << src.rdbuf();
    return src && dest;
}

void getCDResultsForRocket(const std::string& rootDir) {
    std::map<std::string, SessionDataAndResults> sessionMap;
    fs::path rootPath(rootDir);
    std::string fOutNm = rootPath.filename().string();
    std::ofstream fOut;
    std::cout << "Starting CFD Result Analysis for Rocket: " << fOutNm << std::endl;
    size_t pr = rootDir.find_last_of("\\");
    
    std::string cdConfergeFolder = rootDir.substr(0,pr) + "\\CDConferge\\";
    std::cout << "CDConferge folder: " << cdConfergeFolder << std::endl;
    fOutNm = rootDir + "\\" + fOutNm + "_CFD_Results_CD.csv";
    
    for (const auto& entry : fs::directory_iterator(rootPath)) {
        const auto subdir = entry.path().filename().string();
        if (entry.is_directory() && is_number(subdir)) {
            std::string resultFolder = rootDir + "\\" + subdir;
            std::cout << "\n------------------------------\nChecking CFD Result folder: " << resultFolder << " ..." << std::endl;
            fs::path resultPath(resultFolder);
            for (const auto& sentry : fs::directory_iterator(resultPath)) {
                const auto fileName = sentry.path().filename().string();
                size_t p = fileName.find(".json");
                if (p != std::string::npos) {
                    std::string resultFile = resultFolder + "\\" + fileName;
                    std::cout << "Checking Result file: " << resultFile << std::endl;
                    std::ifstream ifs(resultFile);
                    json data = json::parse(ifs);
                    std::string projName = data["project_name"];
                    if (projName.find("0.5") != std::string::npos ||
                        projName.find("1.0") != std::string::npos ||
                        projName.find("1.6") != std::string::npos ||
                        projName.find("3.0") != std::string::npos) {
                        std::string desFile = cdConfergeFolder + projName + ".txt";
                        std::string sourceFile = resultFolder + "\\Goals.DAT\\CD.txt";
                        fs::path dst(desFile);
                        fs::path src(sourceFile);
                        
                        //if (fs::copy_file(src, dst)) {
                        if (copyFile(sourceFile.c_str(), desFile.c_str())) {
                            std::cout << "Successfully copied " << sourceFile << "\nto " << desFile << std::endl;
                        }
                    }
                    SessionDataAndResults dr;
                    dr.fluidCells = data["mesh"]["cells_fluid"];
                    dr.contactCells = data["mesh"]["cells_fluid_containing_solid"];
                    for (auto& elem : data["goals"]) {
                        std::string goalName = elem["goal"]["name"];
                        size_t pDen = goalName.find("Density");
                        size_t pVel = goalName.find("Velocity");

                        size_t pDrag = goalName.find("Force (Z)");
                        size_t pLift = goalName.find("Force (Y)");
                        size_t pSide = goalName.find("Force (X)");

                        size_t pRoll = goalName.find("Torque (Z)");
                        size_t pPitch = goalName.find("Torque (X)");
                        size_t pYaw = goalName.find("Torque (Y)");

                        size_t pCD = goalName.find("CD");
                        size_t pCL = goalName.find("CL");

                        double value = elem["goal"]["value"];
                        double progress = elem["goal"]["progress"];

                        if (pDen != std::string::npos) {
                            dr.density = value;
                            dr.densityProgress = progress;
                            continue;
                        }
                        if (pVel != std::string::npos) {
                            dr.velocity = value;
                            dr.velocityProgress = progress;
                            continue;
                        }
                        if (pDrag != std::string::npos) {
                            dr.drag = value;
                            dr.dragProgress = progress;
                            continue;
                        }
                        if (pLift != std::string::npos) {
                            dr.lift = value;
                            dr.liftProgress = progress;
                            continue;
                        }
                        if (pSide != std::string::npos) {
                            dr.side = value;
                            dr.sideProgress = progress;
                            continue;
                        }
                        if (pRoll != std::string::npos) {
                            dr.roll = value;
                            dr.rollProgress = progress;
                            continue;
                        }
                        if (pPitch != std::string::npos) {
                            dr.pitch = value;
                            dr.pitchProgress = progress;
                            continue;
                        }
                        if (pYaw != std::string::npos) {
                            dr.yaw = value;
                            dr.yawProgress = progress;
                            continue;
                        }
                        if (pCD != std::string::npos) {
                            dr.cD = value;
                            dr.cDProgress = progress;
                            continue;
                        }
                        if (pCL != std::string::npos) {
                            dr.cL = value;
                            dr.cLProgress = progress;
                        }
                    }

                    std::string session = data["project_name"];

                    sessionMap[session] = dr;                    
                }
            }
        }
    }

    if (!fOut.is_open()) {
        fOut.open(fOutNm);
    }

    for (const auto& elem: sessionMap) {
        fOut << elem.first << ", " << elem.second.fluidCells <<  ", " << elem.second.contactCells << ", " << elem.second.cD << ", " << elem.second.cDProgress << std::endl;
    }

    if (fOut.is_open()) {
        fOut.close();
    }
}

void getAllResultsForRocket(const std::string& rootDir) {

    fs::path rootPath(rootDir);
    std::string fOutNm = rootPath.filename().string();
    std::ofstream fOut;
    std::cout << "Starting CFD Result Analysis for Rocket: " << fOutNm << std::endl;
    std::string cdConfergeFolder = rootPath.parent_path().filename().string() + "\\CDConferge\\";
    std::cout << "CDConferge folder: " << cdConfergeFolder << std::endl;
    fOutNm = rootDir + "\\" + fOutNm + "_CFD_Results.csv";
    std::string header = "Session, Fl. cells, Cont. cells, Density [kg/m3], Progress %, Velocity [m/s], Progress %, Drag F [N], Progress %, Lift F [N], Progress %, Side F [N], Progress %, Rolling M [Nm], Progress %, Pitching M [Nm], Progress %, Yawing M [Nm], Progress %, CD, Progress %, CL, Progress %";
    for (const auto& entry : fs::directory_iterator(rootPath)) {
        const auto subdir = entry.path().filename().string();
        if (entry.is_directory() && is_number(subdir)) {
            std::string resultFolder = rootDir + "\\" + subdir;
            std::cout << "\n------------------------------\nChecking CFD Result folder: " << resultFolder << " ..." << std::endl;
            fs::path resultPath(resultFolder);
            for (const auto& sentry : fs::directory_iterator(resultPath)) {
                const auto fileName = sentry.path().filename().string();
                size_t p = fileName.find(".json");
                if (p != std::string::npos) {
                    std::string resultFile = resultFolder + "\\" + fileName;
                    std::cout << "Checking Result file: " << resultFile << std::endl;
                    std::ifstream ifs(resultFile);
                    json data = json::parse(ifs);
                    if (!fOut.is_open()) {
                        fOut.open(fOutNm);
                        fOut << header << std::endl;
                    }
                    else {
                        fOut << data["project_name"] << ", " << data["mesh"]["cells_fluid"] << ", " <<
                            data["mesh"]["cells_fluid_containing_solid"];
                        std::vector<std::pair<double, double>> results(10);
                        std::string projName = data["project_name"];
                        if (projName.find("0.5") != std::string::npos ||
                            projName.find("1.0") != std::string::npos ||
                            projName.find("1.6") != std::string::npos ||
                            projName.find("3.0") != std::string::npos) {
                            std::string desFile = cdConfergeFolder + projName + ".txt";
                            std::string sourceFile = resultFolder + "\\Goals.DAT\\CD.txt";
                            if (copyFile(sourceFile.c_str(), desFile.c_str())) {
                                std::cout << "Successfully copied " << sourceFile << "\nto " << desFile << std::endl;
                            }
                        }
                        for (auto& elem : data["goals"]) {
                            std::string goalName = elem["goal"]["name"];
                            size_t pDen = goalName.find("Density");
                            size_t pVel = goalName.find("Velocity");
                            
                            size_t pDrag = goalName.find("Force (Z)");
                            size_t pLift = goalName.find("Force (Y)");
                            size_t pSide = goalName.find("Force (X)");

                            size_t pRoll = goalName.find("Torque (Z)");
                            size_t pPitch = goalName.find("Torque (X)");
                            size_t pYaw = goalName.find("Torque (Y)");

                            size_t pCD = goalName.find("CD");
                            size_t pCL = goalName.find("CL");

                            double value = elem["goal"]["value"];
                            double progress = elem["goal"]["progress"];

                            if (pDen != std::string::npos) {
                                results[0] = {value, progress};
                            }
                            if (pVel != std::string::npos) {
                                results[1] = { value, progress };
                            }
                            if (pDrag != std::string::npos) {
                                results[2] = { value, progress };
                            }
                            if (pLift != std::string::npos) {
                                results[3] = { value, progress };
                            }
                            if (pSide != std::string::npos) {
                                results[4] = { value, progress };
                            }
                            if (pRoll != std::string::npos) {
                                results[5] = { value, progress };
                            }
                            if (pPitch != std::string::npos) {
                                results[6] = { value, progress };
                            }
                            if (pYaw != std::string::npos) {
                                results[7] = { value, progress };
                            }
                            if (pCD != std::string::npos) {
                                results[8] = { value, progress };
                            }
                            if (pCL != std::string::npos) {
                                results[9] = { value, progress };
                            }
                        }

                        for (size_t i = 0; i < results.size(); ++i) {
                            fOut << ", " << results[i].first << ", " << results[i].second;
                        }
                        fOut << std::endl;
                    }
                }
            }
        }
        
        /*
        const auto filenameStr = entry.path().filename().string();
        
        if (entry.is_directory()) {
            std::cout << "dir:  " << filenameStr << '\n';
        }
        else if (entry.is_regular_file()) {
            std::cout << "file: " << filenameStr << '\n';
        }
        else
            std::cout << "??    " << filenameStr << '\n';
        */
    }

    if (fOut.is_open()) {
        fOut.close();
    }
}

int main()
{
    std::string rocketDir = "D:\\Research\\S-5";
    //getAllResultsForRocket(rocketDir);
    getCDResultsForRocket(rocketDir);
}

// Run program: Ctrl + F5 or Debug > Start Without Debugging menu
// Debug program: F5 or Debug > Start Debugging menu

// Tips for Getting Started: 
//   1. Use the Solution Explorer window to add/manage files
//   2. Use the Team Explorer window to connect to source control
//   3. Use the Output window to see build output and other messages
//   4. Use the Error List window to view errors
//   5. Go to Project > Add New Item to create new code files, or Project > Add Existing Item to add existing code files to the project
//   6. In the future, to open this project again, go to File > Open > Project and select the .sln file
