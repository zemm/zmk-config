#pragma once

/**
 * Common defines
 */

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


/**
 * Keys and keygroups
 *
 * -----------------------------------------------------------------------------------------
 * | 0   | 1   | 2   | 3   | 4   | 5   |   | 6   | 7   | 8   | 9   | 10  | 11  |
 * | 12  | 13  | 14  | 15  | 16  | 17  |   | 18  | 19  | 20  | 21  | 22  | 23  |
 * | 24  | 25  | 26  | 27  | 28  | 29  |   | 30  | 31  | 32  | 33  | 34  | 35  |
 *                   | 36  | 37  | 38  |   | 39  | 40  | 41  |
 */
#if !defined(KEYS_MAIN_L)
	#define KEYS_MAIN_L 0 1 2 3 4 5  12 13 14 15 16 17  24 25 26 27 28 29
#endif
#if !defined(KEYS_MAIN_R)
	#define KEYS_MAIN_R 6 7 8 9 10 11  18 19 20 21 22 23  30 31 32 33 34 35
#endif
#if !defined(KEYS_NONALPHAS_L)
	#define KEYS_NONALPHAS_L 0 12 24
#endif
#if !defined(KEYS_NONALPHAS_R)
	#define KEYS_NONALPHAS_R 35
#endif
#if !defined(KEYS_THUMBS)
	#define KEYS_THUMBS 36 37 38 39 40 41
#endif


/**
 * Spacers
 */

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


/**
 * Combo macros
 */

 // Combo with a shorter timeout
#define COMBO_S(NAME, BINDINGS, KEYPOS, LAYERS) \
	combo_##NAME { \
		bindings = <BINDINGS>; \
		timeout-ms = <20>; \
		key-positions = <KEYPOS>; \
		layers = <LAYERS>; \
	};

// Combo with a longer timeout
#define COMBO_L(NAME, BINDINGS, KEYPOS, LAYERS) \
	combo_##NAME { \
		bindings = <BINDINGS>; \
		timeout-ms = <35>; \
		key-positions = <KEYPOS>; \
		layers = <LAYERS>; \
	};
