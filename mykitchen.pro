QT += quick \
      sql \
      widgets \

HEADERS += \
    src/include/dashrect.h \
    src/include/database.h \
    src/include/inventory/inventory.h \
    src/include/inventory/inventoryList.h \
    src/include/login.h \
    src/include/output/outputmodel.h \
    src/include/product/productmodel.h \
    src/include/profile/saveimage.h \
    src/include/supliermodel/suplier.h \
    src/include/supliermodel/supliercontact.h \
    src/include/product/productList.h\
    src/include/unit/unit.h \
    src/include/input/inputList.h \

SOURCES += \
    src/cpp/dashrect.cpp \
    main.cpp \
    src/cpp/login.cpp \
    src/cpp/product/productmodel.cpp \
    src/cpp/profile/saveimage.cpp \
    src/cpp/supliermodel/suplier.cpp \
    src/cpp/product/productList.cpp\
    src/cpp/unit/unit.cpp \
    src/cpp/supliermodel/supliercontact.cpp \
    src/cpp/input/inputList.cpp \
    src/cpp/inventory/inventory.cpp \
    src/cpp/inventory/inventoryList.cpp \
    src/cpp/output/outputmodel.cpp



#qml resource main file
resources.files += \
        main.qml \
        Splash.qml

#qml resource files
resources.files += AppSettings.qml\
        src/qml/screens/login.qml \
        src/qml/screens/mainScreen.qml \
        src/qml/components/CalendarPicker.qml \
        src/qml/socialNetwork/ContactList.qml \
        src/qml/socialNetwork/components/MessageItem.qml \
        src/qml/socialNetwork/components/HideMessageItem.qml \
        src/qml/store/input/input.qml \
        src/qml/store/output/output.qml \
        Images.qml \
        src/qml/content/FontSizeSettingsForm.qml \
        src/qml/content/NavBarForm.qml \
        src/qml/setting/settingstack.qml \
        src/qml/content/FontSizeSettings.qml \
        src/qml/content/NavBar.qml \
        src/qml/content/SettingsView.qml\
        src/qml/content/SettingsViewForm.qml \
        src/qml/store/supplier/GridMenu.qml \
        src/qml/store/supplier/supplier.qml \
        src/qml/store/supplier/Supplierinfo.qml \
        src/qml/store/supplier/TapView.qml \
        src/qml/store/supplier/ButtonView.qml \
        src/qml/store/supplier/AddView.qml \
        src/qml/store/supplier/ContactView.qml \
        src/qml/store/inventory/GridMenu.qml \
        src/qml/store/inventory/GridMenuForm.qml\
        src/qml/store/inventory/storeHome.qml\
        src/qml/store/inventory/TapView.qml\
        src/qml/store/inventory/TapViewForm.qml\
        src/qml/store/inventory/ButtonView.qml\
        src/qml/store/inventory/ButtonViewForm.qml\
        src/qml/store/inventory/StoreHomeForm.qml \
        src/qml/store/inventory/Main.qml \
        src/qml/store/inventory/PageProduct.qml \
        src/qml/store/inventory/PageInput.qml \
        src/qml/store/inventory/PageInventory.qml \
        src/qml/store/inventory/PageLocation.qml \
        src/qml/store/inventory/PageOutput.qml\
        src/qml/store/inventory/AddTextField.qml \
        src/qml/store/inventory/InfoProduct.qml \
        src/qml/store/input/AddView.qml \
        src/qml/store/input/ButtonView.qml \
        src/qml/store/input/ContactView.qml \
        src/qml/store/input/TapView.qml \
        src/qml/store/input/ProductInfoList.qml \
        src/qml/store/input/InputSupplierDialog.qml \
        src/qml/store/input/InputProductDialog.qml \
        src/qml/store/output/TapView.qml


resources.files += \
        images/logo.png \
        images/search.png \
        images/background-login.jpg \
        images/background.jpg \
        images/user-icon.png \
        images/white-search.png \
        images/clear.png \
        images/user.jpg \
        images/contact.png \
        images/notification.png \
        images/right-arrow.png \
        images/fill-right-arrow.png \
        images/fill-down-arrow.png \
        images/hrm.png \
        images/white-notification.png \
        images/message.png \
        images/my-profile.png \
        images/logout.png \
        images/key.png \
        images/white-minus.png \
        images/send.png \
        images/delete.png \
        images/phone.png \
        images/minimize.png \
        images/grid.png \
        images/home.png \
        images/crm.png \
        images/scm.png \
        images/work.png \
        images/local-social-network.png \
        images/finance.png \
        images/add.png \
        images/import.png \
        images/export.png \
        images/calendar.png \
        images/upload-icon.png \
        images/upload-file.png \
        images/driedfood.jpg \
        images/fruit.jpg \
        images/meat.jpg \
        images/colcut.jpg \
        images/settings.png \
        images/settings_white.png \
        images/Settings_Icon.svg \
        images/qt-logo.png \
        images/Right_Arrow_Icon_Dark.svg \
        images/LeftArrow_Icon_Dark.svg \
        src/qml/content/images/Font_Size_Icon.svg \
        src/qml/content/images/Remove_Done_Icon.svg \
        src/qml/content/images/Style_Icon.svg \
        src/qml/content/images/Tasks_Icon.svg \
        src/qml/content/images/Theme_Icon.svg \
        images/download.png \
        images/remove.png \
        images/Next_Icon.svg\
        images/Before_Icon.svg



resources.prefix = /$${TARGET}

INCLUDEPATH += \

RESOURCES += resources \

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH = $$PWD/imports

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

RC_FILE = images/icons.rc

DISTFILES += \






