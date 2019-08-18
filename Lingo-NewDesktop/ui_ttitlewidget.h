/********************************************************************************
** Form generated from reading UI file 'ttitlewidget.ui'
**
** Created by: Qt User Interface Compiler version 5.12.1
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_TTITLEWIDGET_H
#define UI_TTITLEWIDGET_H

#include <QtCore/QVariant>
#include <QtWidgets/QApplication>
#include <QtWidgets/QPushButton>
#include <QtWidgets/QWidget>

QT_BEGIN_NAMESPACE

class Ui_TTitleWidget
{
public:
    QPushButton *pushButton;
    QPushButton *pushButton_2;

    void setupUi(QWidget *TTitleWidget)
    {
        if (TTitleWidget->objectName().isEmpty())
            TTitleWidget->setObjectName(QString::fromUtf8("TTitleWidget"));
        TTitleWidget->resize(517, 50);
        TTitleWidget->setMinimumSize(QSize(200, 50));
        pushButton = new QPushButton(TTitleWidget);
        pushButton->setObjectName(QString::fromUtf8("pushButton"));
        pushButton->setGeometry(QRect(420, 10, 80, 21));
        pushButton_2 = new QPushButton(TTitleWidget);
        pushButton_2->setObjectName(QString::fromUtf8("pushButton_2"));
        pushButton_2->setGeometry(QRect(310, 10, 80, 21));

        retranslateUi(TTitleWidget);

        QMetaObject::connectSlotsByName(TTitleWidget);
    } // setupUi

    void retranslateUi(QWidget *TTitleWidget)
    {
        TTitleWidget->setWindowTitle(QApplication::translate("TTitleWidget", "Form", nullptr));
        pushButton->setText(QApplication::translate("TTitleWidget", "PushButton", nullptr));
        pushButton_2->setText(QApplication::translate("TTitleWidget", "PushButton", nullptr));
    } // retranslateUi

};

namespace Ui {
    class TTitleWidget: public Ui_TTitleWidget {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_TTITLEWIDGET_H
