#include <iostream>

extern "C" {
    double f(double, double);
}

int main() {
    std::cout << "Mult of 3.0 and 7.0: " << f(3.0, 7.0) << std::endl;
}