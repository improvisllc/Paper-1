#include <filesystem>
#include <fstream>
#include <iostream>
#include <sstream>
#include <string>
#include <vector>

void convertData(const std::string& fName) {
	std::ifstream inFile(fName);
	std::vector<int> iters;
	std::vector<double> values;
	if (inFile.is_open()) {

		std::string line;
		std::getline(inFile, line);
		while (std::getline(inFile, line)) {
			int ctr = 0;
			std::string v;
			std::stringstream ss(line);
			while (std::getline(ss, v, '\t')) {
				if (ctr == 0) {
					iters.push_back(std::stoi(v));
				}
				if (ctr == 4) {
					values.push_back(std::stod(v));
					break;
				}
				++ctr;
			}
		}
		inFile.close();
		size_t p = fName.find_last_of('.');
		std::string fOut = fName.substr(0, p) + ".csv";
		std::ofstream outFile(fOut);
		if (outFile.is_open()) {
			for (size_t i = 0; i < iters.size(); ++i) {
				outFile << iters[i] << "," << values[i] << std::endl;
			}
			outFile.close();
		}
	}
}


int main() {
	
	std::string fPath = "D:/Research/CDConferge";

	std::filesystem::path path(fPath);

	for (const auto& entry : std::filesystem::directory_iterator(path)) {
		if (entry.is_regular_file()) {
			std::string fName = entry.path().string();
			if (fName.find(".txt") != std::string::npos) {
				convertData(fName);
			}
		}
	}

	

	return EXIT_SUCCESS;
}