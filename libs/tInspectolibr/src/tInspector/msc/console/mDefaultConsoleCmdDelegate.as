﻿//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.msc.console {

    public class mDefaultConsoleCmdDelegate implements mIConsoleDelegate {

        private var _console:mConsole;

        public function setConsole(console:mConsole):void{
            this._console = console;
        }
        public function help():void{
            var txt:XML = <txt><![CDATA[<p>mConsole说明</p>
<p>一个简单的控制台程序。</p>
<ul><li>使用时，首先自定义一个mIConsoleDelegate接口的类，这个类里的方法就是mConsole的“命令库”了。</li>
<li>然后在主程序里面通过mConsole.addDelegate(new CustomDelegate());把它添加进去。</li>
<li>打开mConsoleMonitor.swf，就可以用命令行的方式调用CustomDelegate里面的方法了。</li></ul>
<p>TODO List:太多太多了。</br>BUG List:还没有测试过。</p>
]]></txt>
            ;
            this._console.dispatchEvent(new mConsoleLogEvent(new mConsoleLog(txt.toString().replace(/[\n]/g, ""), mConsoleLogType.CONSOLE)));
        }
        public function version():void{
            var msg:String = (((("\nmConsole版本：" + mConsole.VERSION) + "\n") + "mConsoleMonitor版本：") + mConsoleMonitor.VERSION);
            this._console.dispatchEvent(new mConsoleLogEvent(new mConsoleLog(msg, mConsoleLogType.CONSOLE)));
        }
        public function author():void{
            var msg:XML = <help><![CDATA[
tamt, pethan<br>www.msc.cn
			]]></help>
            ;
            this._console.dispatchEvent(new mConsoleLogEvent(new mConsoleLog(msg.toString(), mConsoleLogType.CONSOLE)));
        }
        public function methods():void{
            var methodName:String;
            var arr:Array = this._console.getAllMethodsName();
            var msg:String = "";
            for each (methodName in arr) {
                msg = (msg + ("\n" + methodName));
            };
            this._console.dispatchEvent(new mConsoleLogEvent(new mConsoleLog(msg, mConsoleLogType.CONSOLE)));
        }

    }
}//package msc.console 
