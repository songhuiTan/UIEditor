//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.core.structureview {
    import flash.display.*;

    public class BaseDisplayItemView extends Sprite implements IDisplayItemRenderer {

        protected var _data:DisplayItemData;

        public function BaseDisplayItemView(){
            super();
        }
        public function get data():DisplayItemData{
            return (this._data);
        }
        public function setData(value:DisplayItemData):void{
        }

    }
}//package cn.itamt.utils.inspector.core.structureview 
