#include "ttitlewidget.h"
#include "ui_ttitlewidget.h"

TTitleWidget::TTitleWidget(QWidget *parent) :
    QWidget(parent),
    ui(new Ui::TTitleWidget)
{
    ui->setupUi(this);
}

TTitleWidget::~TTitleWidget()
{
    delete ui;
}
