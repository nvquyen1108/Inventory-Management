import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Dialogs
import QtQuick.Controls.Material

GridMenuForm {
    function getType(type) {
        console.log(type)
        for(var i=0;i<gridview.count;i++){
            if(type === gridview.model.get(i).type){
                mainContain.mainLoader.source = gridview.model.get(i).pageUrl
            }
        }
    }
}
