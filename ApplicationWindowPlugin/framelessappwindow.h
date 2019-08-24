#ifndef FramelessAppWindow_H
#define FramelessAppWindow_H

#include "qsystemdetection.h"
#include <QObject>

#include <QObject>
#include <QQuickWindow>
#include <QList>
#include <QMargins>
#include <QRect>
#include <QSettings>

class FramelessAppWindow : public QQuickWindow
{
    Q_OBJECT
    Q_PROPERTY(bool isMax READ isMax NOTIFY isMaxChanged)
    Q_PROPERTY(bool isFullScreen READ isFullScreen WRITE setIsFullScreen)
public:
    explicit FramelessAppWindow(QQuickWindow *parent = nullptr);

    void setResizeable(bool resizeable=true);
    bool isResizeable(){return m_bResizeable;}

    void setResizeableAreaWidth(int width = 5);

    Q_INVOKABLE bool isMax();
    Q_INVOKABLE void showMin();

    void resizeEvent(QResizeEvent *ev) override;

    bool isFullScreen() const;
    void setIsFullScreen(bool isFullScreen);

protected:
    bool nativeEvent(const QByteArray &eventType, void *message, long *result) override;

signals:
    void isMaxChanged(QVariant val);

private:
    bool m_bResizeable;
    int m_borderWidth;
    QMargins m_margins;
    QMargins m_frames;
    bool m_bJustMaximized;
    bool _isMax;
    bool _isFullScreen;
};

#endif // FramelessAppWindow_H
