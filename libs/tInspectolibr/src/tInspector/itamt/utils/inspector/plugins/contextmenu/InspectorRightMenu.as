//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.plugins.contextmenu {
    import tInspector.itamt.utils.inspector.output.*;
    import flash.ui.*;
    import flash.events.*;
    import tInspector.itamt.utils.inspector.plugins.*;
    import tInspector.itamt.utils.inspector.core.*;
    import tInspector.itamt.utils.*;
    import flash.display.*;

    public class InspectorRightMenu extends BaseInspectorPlugin {

        public static const ON:String = "tInspector on";
        public static const OFF:String = "tInspector off";

        private var _on:ContextMenuItem;
        private var _off:ContextMenuItem;
        private var _pluginItems:Array;
        private var _objs:Array;

        public function InspectorRightMenu(on:Boolean=true){
            super();
            this._on = new ContextMenuItem(ON);
            this._on.separatorBefore = true;
            this._on.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, this.onMenuItemSelect);
            this._off = new ContextMenuItem(OFF);
            this._off.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, this.onMenuItemSelect);
            this._on.enabled = on;
            this._off.enabled = !(on);
            this._pluginItems = [];
        }
        override public function set outputerManager(value:InspectorOutPuterManager):void{
            trace("[InspectorRightMenu][outputerManager]PropertiesView没有设计信息输出的接口，忽略该属性设置。");
        }
        override public function getPluginId():String{
            return (InspectorPluginId.RIGHT_MENU);
        }
        override public function onRegister(inspector:IInspector):void{
            this._inspector = inspector;
            this.apply(inspector.root);
            this.onTurnOff();
        }
        override public function onUnRegister(inspector:IInspector):void{
        }
        override public function onRegisterPlugin(pluginId:String):void{
            var item:PluginMenuItem;
            var menuItem:PluginMenuItem;
            if (pluginId == InspectorPluginId.RIGHT_MENU){
                return;
            };
            for each (item in this._pluginItems) {
                if (item.id == pluginId){
                    return;
                };
            };
            menuItem = new PluginMenuItem(pluginId);
            menuItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, this.onMenuItemSelect);
            this._pluginItems.push(menuItem);
            this.apply(_inspector.root);
        }
        override public function onUnRegisterPlugin(pluginId:String):void{
            var item:PluginMenuItem;
            var t:int;
            for each (item in this._pluginItems) {
                if (item.id == pluginId){
                    item.removeEventListener(ContextMenuEvent.MENU_ITEM_SELECT, this.onMenuItemSelect);
                    t = this._pluginItems.indexOf(item);
                    if (t >= 0){
                        this._pluginItems.splice(t, 1);
                    };
                };
            };
        }
        override public function onActivePlugin(pluginId:String):void{
            var menuItem:PluginMenuItem;
            Debug.trace(("[InspectorRightMenu][onActivePlugin]" + pluginId));
            for each (menuItem in this._pluginItems) {
                if (menuItem.id == pluginId){
                    menuItem.on = true;
                };
            };
        }
        override public function onUnActivePlugin(pluginId:String):void{
            var menuItem:PluginMenuItem;
            Debug.trace(("[InspectorRightMenu][onUnActivePlugin]" + pluginId));
            for each (menuItem in this._pluginItems) {
                if (menuItem.id == pluginId){
                    menuItem.on = false;
                };
            };
        }
        override public function onTurnOn():void{
            var menuItem:PluginMenuItem;
            this._on.enabled = false;
            this._off.enabled = true;
            _inspector.pluginManager.activePlugin(this.getPluginId());
            for each (menuItem in this._pluginItems) {
                menuItem.enabled = true;
                if (menuItem.on){
                    _inspector.pluginManager.activePlugin(menuItem.id);
                };
            };
        }
        override public function onTurnOff():void{
            var menuItem:PluginMenuItem;
            this._on.enabled = true;
            this._off.enabled = false;
            for each (menuItem in this._pluginItems) {
                menuItem.enabled = false;
            };
        }
        public function apply(obj:InteractiveObject):void{
            var item:PluginMenuItem;
            if (this._objs == null){
                this._objs = [];
            };
            if (this._objs.indexOf(obj) < 0){
                this._objs.push(obj);
            };
            var menu:ContextMenu = obj.contextMenu;
            if (menu == null){
                menu = new ContextMenu();
            };
            menu.customItems.push(this._on);
            menu.customItems.push(this._off);
            for each (item in this._pluginItems) {
                menu.customItems.push(item.target);
            };
            obj.contextMenu = menu;
        }
        private function onMenuItemSelect(evt:ContextMenuEvent):void{
            var menuItem:PluginMenuItem;
            switch (evt.target){
                case this._on:
                    _inspector.turnOn();
                    break;
                case this._off:
                    _inspector.turnOff();
                    break;
                default:
                    for each (menuItem in this._pluginItems) {
                        if (menuItem.target == evt.target){
                            if (menuItem.on){
                                _inspector.pluginManager.unactivePlugin(menuItem.id);
                            } else {
                                _inspector.pluginManager.activePlugin(menuItem.id);
                            };
                            break;
                        };
                    };
            };
        }

    }
}//package cn.itamt.utils.inspector.plugins.contextmenu 

import flash.ui.*;
import tInspector.itamt.utils.inspector.core.*;
import tInspector.itamt.utils.*;
import tInspector.itamt.utils.inspector.lang.*;

class PluginMenuItem {

    private var _on:Boolean;
    private var _id:String;
    public var target:ContextMenuItem;

    public function PluginMenuItem(id:String):void{
        super();
        this._id = id;
        var plugin:IInspectorPlugin = Inspector.getInstance().pluginManager.getPluginById(id);
        this.target = new ContextMenuItem(plugin.getPluginName(InspectorLanguageManager.getLanguage()), false, false);
    }
    public function set on(value:Boolean):void{
        this._on = value;
        var plugin:IInspectorPlugin = Inspector.getInstance().pluginManager.getPluginById(this.id);
        if (this._on){
            this.target.caption = (plugin.getPluginName(InspectorLanguageManager.getLanguage()) + "\t√");
        } else {
            this.target.caption = plugin.getPluginName(InspectorLanguageManager.getLanguage());
        };
    }
    public function get on():Boolean{
        return (this._on);
    }
    public function get id():String{
        return (this._id);
    }
    public function addEventListener(type:String, listener:Function):void{
        this.target.addEventListener(type, listener);
    }
    public function removeEventListener(type:String, listener:Function):void{
        this.target.removeEventListener(type, listener);
    }
    public function set enabled(val:Boolean):void{
        this.target.enabled = val;
    }
    public function get enabled():Boolean{
        return (this.target.enabled);
    }

}
