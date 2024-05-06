#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "src/include/login.h"
#include <QDebug>
#include "src/include/database.h"
#include "src/include/supliermodel/suplier.h"
#include "src/include/supliermodel/supliercontact.h"
#include "src/include/product/productList.h"
#include "src/include/profile/saveimage.h"
#include "src/include/unit/unit.h"
#include "src/include/product/productmodel.h"
#include "src/include/input/inputList.h"
#include "src/include/output/outputmodel.h"
#include "src/include/inventory/inventory.h"
#include "src/include/inventory/inventoryList.h"
#include "src/include/dashrect.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);


    if (!createConnection())
        return EXIT_FAILURE;
    app.setApplicationName("ToDoLists");
    app.setOrganizationName("QtProject");
    app.setOrganizationDomain("ToDoList");

    qmlRegisterType<Suplier>("Suplier.App", 1, 0, "SqlSuplierModel");
    qmlRegisterType<SuplierContact>("Suplier.Add", 1, 0, "SqlSuplierList");
    qmlRegisterType<Unit>("Unit.App", 1, 0, "SqlUnitModel");
    qmlRegisterType<ProductModel>("Product.App", 1, 0, "SqlProductModel");
    qmlRegisterType<ProductList>("Product.List", 1, 0, "SqlProductList");
    qmlRegisterType<InputList>("Input.List", 1, 0, "SqlInputList");
    qmlRegisterType<OutputModel>("Output.Model", 1, 0, "SqlOutputModel");
    qmlRegisterType<Inventory>("Inventory.Model", 1, 0, "SqlInventoryModel");
    qmlRegisterType<InventoryList>("Inventory.List", 1, 0, "SqlInventoryList");
    qmlRegisterType<SaveImages>("SaveImage.App",1,0,"SaveImages");
    qmlRegisterType<DashRect>("Custom", 1, 0, "DashRect");

    qmlRegisterType<LoginAuth>("login.auth",1,0,"LoginAuth");

    QQmlApplicationEngine engine;

    const QUrl url(u"qrc:/mykitchen/main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
        &app, [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        }, Qt::QueuedConnection);
    engine.load(url);


    return app.exec();
}
