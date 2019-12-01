/****************************************************************************
** Meta object code from reading C++ file 'framelessappwindow.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.12.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../framelessappwindow.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'framelessappwindow.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.12.1. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_FramelessAppWindow_t {
    QByteArrayData data[10];
    char stringdata0[107];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_FramelessAppWindow_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_FramelessAppWindow_t qt_meta_stringdata_FramelessAppWindow = {
    {
QT_MOC_LITERAL(0, 0, 18), // "FramelessAppWindow"
QT_MOC_LITERAL(1, 19, 12), // "isMaxChanged"
QT_MOC_LITERAL(2, 32, 0), // ""
QT_MOC_LITERAL(3, 33, 3), // "val"
QT_MOC_LITERAL(4, 37, 17), // "windowIconChanged"
QT_MOC_LITERAL(5, 55, 5), // "isMax"
QT_MOC_LITERAL(6, 61, 7), // "showMin"
QT_MOC_LITERAL(7, 69, 13), // "setWindowIcon"
QT_MOC_LITERAL(8, 83, 10), // "windowIcon"
QT_MOC_LITERAL(9, 94, 12) // "isFullScreen"

    },
    "FramelessAppWindow\0isMaxChanged\0\0val\0"
    "windowIconChanged\0isMax\0showMin\0"
    "setWindowIcon\0windowIcon\0isFullScreen"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_FramelessAppWindow[] = {

 // content:
       8,       // revision
       0,       // classname
       0,    0, // classinfo
       5,   14, // methods
       3,   48, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       2,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    1,   39,    2, 0x06 /* Public */,
       4,    0,   42,    2, 0x06 /* Public */,

 // methods: name, argc, parameters, tag, flags
       5,    0,   43,    2, 0x02 /* Public */,
       6,    0,   44,    2, 0x02 /* Public */,
       7,    1,   45,    2, 0x02 /* Public */,

 // signals: parameters
    QMetaType::Void, QMetaType::QVariant,    3,
    QMetaType::Void,

 // methods: parameters
    QMetaType::Bool,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString,    8,

 // properties: name, type, flags
       5, QMetaType::Bool, 0x00495001,
       9, QMetaType::Bool, 0x00095103,
       8, QMetaType::QString, 0x00495103,

 // properties: notify_signal_id
       0,
       0,
       1,

       0        // eod
};

void FramelessAppWindow::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<FramelessAppWindow *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->isMaxChanged((*reinterpret_cast< QVariant(*)>(_a[1]))); break;
        case 1: _t->windowIconChanged(); break;
        case 2: { bool _r = _t->isMax();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 3: _t->showMin(); break;
        case 4: _t->setWindowIcon((*reinterpret_cast< const QString(*)>(_a[1]))); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (FramelessAppWindow::*)(QVariant );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&FramelessAppWindow::isMaxChanged)) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (FramelessAppWindow::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&FramelessAppWindow::windowIconChanged)) {
                *result = 1;
                return;
            }
        }
    }
#ifndef QT_NO_PROPERTIES
    else if (_c == QMetaObject::ReadProperty) {
        auto *_t = static_cast<FramelessAppWindow *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< bool*>(_v) = _t->isMax(); break;
        case 1: *reinterpret_cast< bool*>(_v) = _t->isFullScreen(); break;
        case 2: *reinterpret_cast< QString*>(_v) = _t->windowIcon(); break;
        default: break;
        }
    } else if (_c == QMetaObject::WriteProperty) {
        auto *_t = static_cast<FramelessAppWindow *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 1: _t->setIsFullScreen(*reinterpret_cast< bool*>(_v)); break;
        case 2: _t->setWindowIcon(*reinterpret_cast< QString*>(_v)); break;
        default: break;
        }
    } else if (_c == QMetaObject::ResetProperty) {
    }
#endif // QT_NO_PROPERTIES
}

QT_INIT_METAOBJECT const QMetaObject FramelessAppWindow::staticMetaObject = { {
    &QQuickWindow::staticMetaObject,
    qt_meta_stringdata_FramelessAppWindow.data,
    qt_meta_data_FramelessAppWindow,
    qt_static_metacall,
    nullptr,
    nullptr
} };


const QMetaObject *FramelessAppWindow::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *FramelessAppWindow::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_FramelessAppWindow.stringdata0))
        return static_cast<void*>(this);
    return QQuickWindow::qt_metacast(_clname);
}

int FramelessAppWindow::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QQuickWindow::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 5)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 5;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 5)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 5;
    }
#ifndef QT_NO_PROPERTIES
   else if (_c == QMetaObject::ReadProperty || _c == QMetaObject::WriteProperty
            || _c == QMetaObject::ResetProperty || _c == QMetaObject::RegisterPropertyMetaType) {
        qt_static_metacall(this, _c, _id, _a);
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 3;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void FramelessAppWindow::isMaxChanged(QVariant _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void FramelessAppWindow::windowIconChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
