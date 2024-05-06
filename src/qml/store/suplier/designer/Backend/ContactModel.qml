// Copyright (C) 2017 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick

ListModel {
    id: appsModel
    property int index : 0
    ListElement {
        type: "dryfood"
        name: "Thực phẩm khô"
        address: ""
        email: ""
        pageUrl: "qrc:/mykitchen/src/qml/store/suplier/suplierlist/suplierlist.qml"
        imageUrl: "qrc:/mykitchen/images/driedfood.jpg"
        avisible: false
    }
}
