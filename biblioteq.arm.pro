include(biblioteq-source.pro)

greaterThan(QT_MAJOR_VERSION, 4) {
cache()
}

purge.commands = rm -f *~ && rm -f */*~

CONFIG		+= copy_dir_files qt release thread warn_on
DEFINES		+= BIBLIOTEQ_CONFIGFILE="'\"biblioteq.conf\"'"
LANGUAGE	= C++
QT		+= network sql
QT		-= webkit

lessThan(QT_MAJOR_VERSION, 5) {
exists(/usr/include/poppler/qt4) {
DEFINES +=      BIBLIOTEQ_LINKED_WITH_POPPLER
INCLUDEPATH     += /usr/include/poppler/qt4
LIBS    +=      -lpoppler-qt4
QMAKE_CXXFLAGS_RELEASE += -Wno-deprecated-declarations
}
}
else {
exists(/usr/include/poppler/qt5) {
DEFINES +=      BIBLIOTEQ_LINKED_WITH_POPPLER
INCLUDEPATH     += /usr/include/poppler/qt5
LIBS    +=      -lpoppler-qt5
}
}

exists(/usr/include/poppler/cpp) {
DEFINES +=     BIBLIOTEQ_POPPLER_VERSION_DEFINED
INCLUDEPATH += /usr/include/poppler/cpp
}
else {
message("The directory /usr/include/poppler/cpp does not exist. Poppler version information will not be available.")
}

greaterThan(QT_MAJOR_VERSION, 4) {
QT              += printsupport widgets
}

QMAKE_CLEAN	+= BiblioteQ
QMAKE_CXXFLAGS_RELEASE += -Wall -Wcast-qual -Wextra \
			  -Wformat=2 -Woverloaded-virtual -Wpointer-arith \
			  -Wstrict-overflow=5 \
			  -Wstack-protector -fPIE -fstack-protector-all \
                          -fwrapv -mtune=native -pie
QMAKE_DISTCLEAN += -r temp

greaterThan(QT_MAJOR_VERSION, 4) {
QMAKE_DISTCLEAN += .qmake.cache .qmake.stash
}

QMAKE_EXTRA_TARGETS = purge

ICON		= Icons/book.png
INCLUDEPATH	+= Source temp
LIBS		+= -lsqlite3 -lyaz
PROJECTNAME	= BiblioteQ
RESOURCES	= Icons/icons.qrc
TEMPLATE        = app
TARGET		= BiblioteQ
