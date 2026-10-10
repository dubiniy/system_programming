#include <stdio.h>

int main() {
    long long a, b, c;

    printf("Введите a, b, c: ");
    if (scanf("%lld %lld %lld", &a, &b, &c) != 3 || b == 0) {
        printf("Ошибка ввода или b = 0\n");
        return 1;
    }

    printf("Результат = %lld\n", ((b - c) / b) + a);
    return 0;
}