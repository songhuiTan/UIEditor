package ll.utils
{
	/**
	 * 时间处理工具 
	 * @author silenxiao
	 * 
	 */	
	public class DateUtil
	{
		/**
		 * @param leftTime	剩余时间，单位：秒
		 * @return 			返回 23时59分59秒
		 *
		 * 格式化时间 
		 * 通过秒数返回:日时分秒
		 */
		public static function getTimeFromSecsInDay(leftTime:int):String{
			var showTime:String = "<font>";
			if(leftTime > 86400){
				showTime = int(leftTime / 86400).toString() + "天"+ int(leftTime % 86400 / 3600).toString() + "小时" +
					"</font>";
			}else if(leftTime > 3600){
				showTime = int(leftTime / 3600).toString() +"小时" + int((leftTime % 3600) / 60).toString() + "分"+ int((leftTime % 3600) % 60).toString() + "秒" +
					"</font>";
			}else if(leftTime >= 60){
				showTime = int((leftTime % 3600) / 60).toString() + "分" + int((leftTime % 3600) % 60).toString() + "秒"+
					"</font>";
			}else{
				showTime =  int((leftTime % 3600) % 60).toString() +"秒" +
					"</font>";
			}
			return showTime;
			
		}
		
		/**
		 * @param leftTime	剩余时间，单位：秒
		 * @param type	
		 * @return 			type==0时返回 23时59分59秒 type==1时返回 23:59:59
		 */		
		public static function getTimeUnitFromSecs(leftTime:int,type:int=0):String
		{
			var hh:int=int(leftTime / 3600);
			var mm:int=int((leftTime % 3600) / 60);
			var ss:int=(leftTime % 3600) % 60;
			var timeString:String
			if (hh != 0){
				timeString=hh.toString() + (type==0?"时":":");
			}else{
				timeString="";
			}
			if (mm < 10){
				if(hh==0 && mm==0){
					timeString="";
				}else{
					timeString=timeString + "0" + mm.toString() + (type==0?"分":":");
				}
			}else{
				timeString=timeString + mm.toString() + (type==0?"分":":");
			}
			if (ss < 10){
				timeString=timeString + "0" + ss.toString()+ (type==0?"秒":"");
			}else{
				timeString=timeString + ss.toString()+(type==0?"秒":"");
			}
			return timeString;
		}
		
		/**
		 * @param leftTime	剩余时间，单位：秒
		 * @return 			返回  3天23时59分
		 */		
		public static function getTimeMoreThanDay(leftTime:uint):String
		{
			var days:uint=uint(leftTime/86400);
			var dayStr:String="";
			if(days>0){
				dayStr=days+"天"
			}
			return dayStr + getTimeUnitFromMinu(int(leftTime%86400));
		}
		
		
		/**
		 * @param leftTime	剩余时间，单位：秒
		 * @return 			返回 23时59分
		 */		
		public static function getTimeUnitFromMinu(leftTime:int):String
		{
			var hh:int=int(leftTime / 3600);
			var mm:int=int((leftTime % 3600) / 60);
			var timeString:String
			if (hh != 0)
				timeString=hh.toString() + "时";
			else
				timeString="";
			
			if (mm < 10)
			{
				if(hh==0 && mm==0)
					timeString = "0" + "分";
				else
					timeString=timeString + "0" + mm.toString() + "分";
			}
			else
				timeString=timeString + mm.toString() + "分";
			return timeString;
		}
		
		/**
		 * 格式化时间 (1小时内)
		 * 通过秒数返回00:00
		 */
		public static function getTimeFromSecsInHour(leftTime:int):String
		{
			var hh:int=int(leftTime / 3600);
			var mm:int=int((leftTime % 3600) / 60);
			var ss:int=(leftTime % 3600) % 60;
			var timeString:String
			if (hh != 0){
				timeString=hh.toString() + "时";
			}else{
				timeString="";
			}
			if (mm < 10){
				if(hh==0 && mm==0){
					timeString="";
				}else{
					timeString=timeString + "0" + mm.toString() + "分";
				}
			}else{
				timeString=timeString + mm.toString() + "分";
			}
			if (ss < 10){
				timeString=timeString + "0" + ss.toString()+ "秒";
			}else{
				timeString=timeString + ss.toString()+ "秒";
			}
			return timeString;
		}
		
		/**
		 * 格式化时间 
		 * 通过秒数返回:2012年01月08日23时59分59秒
		 */
		public static function getChinaTimeFormat(leftTime:int, isHaveTime:Boolean=true):String
		{
			var temp:Date=new Date();
			temp.setTime(leftTime*1000);
			var dayint:int=int(temp.getDate());
			var daystr:String;
			if(dayint<10){
				daystr="0"+dayint;
			}else
			{
				daystr=""+dayint;
			}
			var monint:int=int(temp.getMonth())+1;
			var monstr:String;
			if(monint<10){
				monstr="0"+monint;
			}else
			{
				monstr=""+monint;
			}
			
			var timeStr:String;
			if(isHaveTime)
				timeStr = temp.getFullYear()+"年"+monstr+"月"+daystr+"日"+temp.hours+"时"+temp.getMinutes()+"分"+temp.getSeconds()+"秒";
			else
				timeStr = temp.getFullYear()+"年"+monstr+"月"+daystr+"日";
			return timeStr;
		}
		/**
		 *判断是否同一天 
		 * @param leftTime
		 * @param serverTime
		 * @return 
		 * 
		 */		
		public static function isSameDay(leftTime:int ,serverTime:int):Boolean{
			var leftDate:Date=new Date();
			leftDate.setTime(leftTime*1000);
			var serverDate:Date=new Date();
			serverDate.setTime(serverTime*1000);
			if(leftDate.getFullYear()!=serverDate.getFullYear())
				return false;
			if(leftDate.getMonth()!=serverDate.getMonth())
				return false;
			if(leftDate.getDate()!=serverDate.getDate())
				return false;
			return true;
		}
		
		/**
		 * 格式化时间
		 * leftTime		剩余时间，单位秒
		 * type=0 		返回 23:59:59
		 */
		public static function getTimeFromSecs(leftTime:int):String
		{
			var hh:int=int(leftTime / 3600);
			var mm:int=int((leftTime % 3600) / 60);
			var ss:int=(leftTime % 3600) % 60;
			var timeString:String;
			if (hh != 0){
				timeString=hh.toString()+":";
			}else{
				timeString="";
			}
			if (mm < 10){
				timeString=timeString + "0" + mm.toString()+":";
			}else{
				timeString=timeString + mm.toString()+":";
			}
			if (ss < 10){
				timeString=timeString + "0" + ss.toString();
			}else{
				timeString=timeString + ss.toString();
			}
			return timeString;
		}
		
		/**
		 * @param dateStr	格式：2010-01-01 12:00:00
		 * @return 			秒数
		 */		
		public static function getSeconds(dateStr:String):uint
		{
			var temp:String;
			var year:int;
			var month:int;
			var date:int;
			temp=dateStr.split(" ")[0];
			year=int(temp.split("-")[0]);
			month=int(temp.split("-")[1]);
			date=int(temp.split("-")[2]);
			
			var hours:int=0;
			var minutes:int=0;
			var seconds:int=0;
			temp=dateStr.split(" ")[1];
			if(temp){
				hours=int(temp.split(":")[0]);
				minutes=int(temp.split(":")[1]);
				seconds=int(temp.split(":")[2]);
			}
			var theDate:Date=new Date(year,month-1,date,hours,minutes,seconds);
			return theDate.getTime()/1000;
		}
		
	}
}