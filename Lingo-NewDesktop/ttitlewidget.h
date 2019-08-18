#ifndef TTITLEWIDGET_H
#define TTITLEWIDGET_H

#include <QWidget>

namespace Ui {
class TTitleWidget;
}

class TTitleWidget : public QWidget
{
    Q_OBJECT

public:
    explicit TTitleWidget(QWidget *parent = nullptr);
    ~TTitleWidget();

private:
    Ui::TTitleWidget *ui;
};

#endif // TTITLEWIDGET_H
