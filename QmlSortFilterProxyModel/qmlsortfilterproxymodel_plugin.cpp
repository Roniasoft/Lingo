#include "qmlsortfilterproxymodel_plugin.h"
#include "qqmlsortfilterproxymodel.h"

#include "sorters/sorter.h"
#include "sorters/rolesorter.h"
#include "sorters/stringsorter.h"
#include "sorters/filtersorter.h"
#include "sorters/expressionsorter.h"

#include "filters/filter.h"
#include "filters/valuefilter.h"
#include "filters/indexfilter.h"
#include "filters/regexpfilter.h"
#include "filters/rangefilter.h"
#include "filters/expressionfilter.h"
#include "filters/anyoffilter.h"
#include "filters/alloffilter.h"

#include "proxyroles/proxyrole.h"
#include "proxyroles/joinrole.h"
#include "proxyroles/switchrole.h"
#include "proxyroles/expressionrole.h"
#include "proxyroles/regexprole.h"
#include "proxyroles/filterrole.h"

#include <qqml.h>
using namespace qqsfpm;
void QmlSortFilterProxyModelPlugin::registerTypes(const char *uri)
{

    Q_ASSERT(uri == QLatin1String("SortFilterProxyModel"));
    // @uri com.mycompany.qmlcomponents
    qmlRegisterType<QQmlSortFilterProxyModel>(uri, 0, 2, "QQmlSortFilterProxyModel");

    qmlRegisterUncreatableType<Sorter>(uri, 0, 2, "Sorter", "Sorter is an abstract class");
    qmlRegisterType<RoleSorter>(uri, 0, 2, "RoleSorter");
    qmlRegisterType<StringSorter>(uri, 0, 2, "StringSorter");
    qmlRegisterType<FilterSorter>(uri, 0, 2, "FilterSorter");
    qmlRegisterType<ExpressionSorter>(uri, 0, 2, "ExpressionSorter");

    qmlRegisterUncreatableType<Filter>(uri, 0, 2, "Filter", "Filter is an abstract class");
    qmlRegisterType<ValueFilter>(uri, 0, 2, "ValueFilter");
    qmlRegisterType<IndexFilter>(uri, 0, 2, "IndexFilter");
    qmlRegisterType<RegExpFilter>(uri, 0, 2, "RegExpFilter");
    qmlRegisterType<RangeFilter>(uri, 0, 2, "RangeFilter");
    qmlRegisterType<ExpressionFilter>(uri, 0, 2, "ExpressionFilter");
    qmlRegisterType<AnyOfFilter>(uri, 0, 2, "AnyOf");
    qmlRegisterType<AllOfFilter>(uri, 0, 2, "AllOf");

    qmlRegisterUncreatableType<ProxyRole>(uri, 0, 2, "ProxyRole", "ProxyRole is an abstract class");
    qmlRegisterType<JoinRole>(uri, 0, 2, "JoinRole");
    qmlRegisterType<SwitchRole>(uri, 0, 2, "SwitchRole");
    qmlRegisterType<ExpressionRole>(uri, 0, 2, "ExpressionRole");
    qmlRegisterType<RegExpRole>(uri, 0, 2, "RegExpRole");
    qmlRegisterType<FilterRole>(uri, 0, 2, "FilterRole");
}

