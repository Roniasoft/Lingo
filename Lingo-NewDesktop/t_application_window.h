#ifndef T_APPLICATIO_NWINDOW_H
#define T_APPLICATIO_NWINDOW_H

#include "qsystemdetection.h"
#include <QObject>
#include <QMainWindow>

#include <QObject>
#include <QQuickWindow>
#include <QWidget>
#include <QList>
#include <QMargins>
#include <QRect>

class TApplicationWindow : public QQuickWindow
{
    Q_OBJECT
    Q_PROPERTY(bool isMax READ isMax NOTIFY isMaxChanged)
public:
    explicit TApplicationWindow(QQuickWindow *parent = nullptr);

    void setResizeable(bool resizeable=true);
    bool isResizeable(){return m_bResizeable;}

    void setResizeableAreaWidth(int width = 5);

    Q_INVOKABLE bool isMax();
    Q_INVOKABLE void showMin();

    void resizeEvent(QResizeEvent *ev) override;

protected:
    //generally, we can add widget say "label1" on titlebar, and it will cover the titlebar under it
    //as a result, we can not drag and move the MainWindow with this "label1" again
    //we can fix this by add "label1" to a ignorelist, just call addIgnoreWidget(label1)
    void addIgnoreWidget(QWidget* widget);

    bool nativeEvent(const QByteArray &eventType, void *message, long *result);

signals:
    void isMaxChanged(QVariant val);

public slots:
    void onTitleBarDestroyed();

private:

    QWidget* m_titlebar;
    QList<QWidget*> m_whiteList;
    bool m_bResizeable;
    int m_borderWidth;

    QMargins m_margins;
    QMargins m_frames;
    bool m_bJustMaximized;

    bool _isMax;

};

#endif // T_APPLICATIO_NWINDOW_H
