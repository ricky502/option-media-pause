#include <CoreGraphics/CoreGraphics.h>
#include <stdio.h>

int main() {
    CGEventFlags flags = CGEventSourceFlagsState(kCGEventSourceStateHIDSystemState);
    printf("%d\n", (flags & kCGEventFlagMaskAlternate) ? 1 : 0);
    return 0;
}
