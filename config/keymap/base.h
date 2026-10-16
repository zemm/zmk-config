#pragma once

//
// Common defines
//

// Modifiers for left/right side
#define LM1 LGUI
#define LM2 LALT
#define LM3 LSHFT
#define LM4 LCTRL
#define RM1 RCTRL
#define RM2 RSHFT
#define RM3 LALT
#define RM4 RGUI

// Shortenings
#define KP_MUL KP_MULTIPLY
#define KP_DIV KP_DIVIDE
#define KP_RET KP_ENTER
#define EURO RA(N5)

#if !defined(__K__)
    #define __K__
#endif
#if !defined(__H__)
    #define __H__
#endif
#if !defined(__M__)
    #define __M__
#endif
#if !defined(__L__)
    #define __L__
#endif
#if !defined(__T__)
    #define __T__
#endif
#if !defined(___)
    #define ___
#endif

#if !defined(KM_THUMBS)
    #define KM_THUMBS( \
        L_SEC, L_PRI, L_AUX, MIDDLE, R_AUX, R_PRI, R_SEC \
    ) \
    L_SEC L_PRI L_AUX R_AUX R_PRI R_SEC
#endif
