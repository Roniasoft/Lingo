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
    Q_PROPERTY(QString windowIcon READ windowIcon WRITE setWindowIcon NOTIFY windowIconChanged)
public:
    explicit FramelessAppWindow(QQuickWindow *parent = nullptr);

    void setResizeable(bool resizeable=true);
    bool isResizeable(){return m_bResizeable;}

    Q_INVOKABLE bool isMax();
    Q_INVOKABLE void showMin();

    void resizeEvent(QResizeEvent *ev) override;

    bool isFullScreen() const;
    void setIsFullScreen(bool isFullScreen);


    QString windowIcon() const;
    Q_INVOKABLE void setWindowIcon(const QString &windowIcon);

protected:
    bool nativeEvent(const QByteArray &eventType, void *message, long *result) override;

signals:
    void isMaxChanged(QVariant val);
    void windowIconChanged();

private:
    bool m_bResizeable;
    int m_borderWidth;
    QMargins m_margins;
    QMargins m_frames;
    bool m_bJustMaximized;
    bool _isMax;
    bool _isFullScreen;
    QString _windowIcon;
};

#endif // FramelessAppWindow_H
