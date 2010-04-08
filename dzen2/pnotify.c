/*
 *    pnotify (c) Alexander Polakov <polachok@gmail.com>
 */

#include <stdio.h>
#include <string.h>
#include <locale.h>
#include <X11/Xlib.h>
#include <X11/Xutil.h>
#include <X11/Xatom.h>

Display *dpy;
Window root;
int screen;

int
main(int argc, char *argv[]) {
	if(!(dpy = XOpenDisplay(0)))
            return 1;
	screen = DefaultScreen(dpy);
	root = RootWindow(dpy, screen);
	XEvent ev;

        /* main event loop */
	XSelectInput(dpy, root, PropertyChangeMask);
	XNextEvent(dpy, &ev);
}

