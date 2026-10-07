#include <stdio.h>

int main() {
    long long n = 1167271174; 
    long long sum = 0;

    while (n > 0) {
        sum += n % 10;
        n /= 10;
    }
    
    printf("%lld\n", sum);
    return 0;
}