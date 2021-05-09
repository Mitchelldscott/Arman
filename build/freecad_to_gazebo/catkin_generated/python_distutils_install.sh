#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/m_dyse/Arman/src/freecad_to_gazebo"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/m_dyse/Arman/nit/lib/python2.7/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/m_dyse/Arman/nit/lib/python2.7/dist-packages:/home/m_dyse/Arman/build/freecad_to_gazebo/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/m_dyse/Arman/build/freecad_to_gazebo" \
    "/usr/bin/python2" \
    "/home/m_dyse/Arman/src/freecad_to_gazebo/setup.py" \
     \
    build --build-base "/home/m_dyse/Arman/build/freecad_to_gazebo" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/m_dyse/Arman/nit" --install-scripts="/home/m_dyse/Arman/nit/bin"
