package backend;

import psychlua.LuaUtils;
import psychlua.FunkinLua;


enum ModchartEventType {
    SetShaderProperty;
    TweenShaderProperty;
    AddCameraZoom;
    AddHUDZoom;
}

typedef ModchartEvent = {
    var type:ModchartEventType;
    var step:Float;
    var ?name:String;
    var ?value:Float;
    var ?time:Float;
    var ?ease:Float->Float;
    var ?startValue:Float;
} 

typedef ShaderTimeData = {
    var shaderName:String;
    var iTime:Float;
    var hasSpeed:Bool;
}

class ModchartLoader {

    public function new() {
        loadModchartEvents();
    }

    public var defaultValues:Map<String, Float> = [];
    public var events:Array<ModchartEvent> = [];
    public var iTimeShaderData:Array<ShaderTimeData> = [];

    private function loadShaderScript() {
        #if LUA_ALLOWED
		var doPush:Bool = false;
		var luaFile:String = 'shaders.lua';
		#if MODS_ALLOWED
		var replacePath:String = Paths.modFolders(luaFile);
		if(FileSystem.exists(replacePath))
		{
			luaFile = replacePath;
			doPush = true;
		}
		else
		{
			luaFile = Paths.getSharedPath(luaFile);
			if(FileSystem.exists(luaFile))
				doPush = true;
		}
		#else
		luaFile = Paths.getSharedPath(luaFile);
		if(Assets.exists(luaFile)) doPush = true;
		#end

		if(doPush)
		{
			for (script in PlayState.instance.luaArray)
			{
				if(script.scriptName == luaFile)
				{
					doPush = false;
					break;
				}
			}
			if(doPush) new FunkinLua(luaFile);
		}
		#end
    }
    
    private function loadModchartEvents() {
        if (!ClientPrefs.data.shaders) return;

        var song = Paths.formatToSongPath(PlayState.SONG.song);
        var xmlPath = "data/"+song+"/modchart.xml";
        if (Paths.fileExists("data/"+song+"/modchart-" + Difficulty.getString().toLowerCase() + ".xml", TEXT, false)) {
            xmlPath = "data/"+song+"/modchart-" + Difficulty.getString().toLowerCase() + ".xml";
        }
        if (!Paths.fileExists(xmlPath, TEXT, false)) return;
    
        loadShaderScript();
        var xml = Xml.parse(Paths.getTextFromFile(xmlPath)).firstElement();

        for (list in xml.elementsNamed("Init")) {
            for (event in list.elementsNamed("Event")) {
                switch(event.get("type")) {
                    case "initShader":
                        
                        var path = event.get("shader");
                        var vars:Array<String> = [];
                        var values:Array<Float> = [];
                        var iTimeData:ShaderTimeData = null;

                        if (Paths.fileExists("shaders/"+path+".txt", TEXT, false)) {
                            var data = Paths.getTextFromFile("shaders/"+path+".txt");
                            for (vari in data.split("\n")) {
                                var d = vari.split(" ");

                                vars.push(d[0]);
                                values.push(Std.parseFloat(d[1]));

                                defaultValues.set(d[0], Std.parseFloat(d[1]));
    
                                if (d[0] == 'iTime') {
                                    if (iTimeData == null) iTimeData = {shaderName: event.get("name"), iTime: 0, hasSpeed: false};
                                }
                                if (d[0] == "speed") {
                                    if (iTimeData == null) iTimeData = {shaderName: event.get("name"), iTime: 0, hasSpeed: false};
                                    iTimeData.hasSpeed = true;
                                }
                            }
                        }
                        if (iTimeData != null) {
                            iTimeShaderData.push(iTimeData);
                        }
    
                        PlayState.instance.callOnScripts("initShader", [event.get("name"), event.get("shader"),vars,values]);
                    case "setCameraShader":
                        PlayState.instance.callOnScripts("setCameraShader", [event.get("camera"), event.get("name")]);
    
                    case "setShaderProperty":
                        var n = event.get("name") + event.get("property");
                        set(n, Std.parseFloat(event.get("value")));
                        defaultValues.set(n, Std.parseFloat(event.get("value")));
                }
            }
        }


        for (list in xml.elementsNamed("Events")) {
            for (event in list.elementsNamed("Event")) {
                switch(event.get("type")) {
                    case "setShaderProperty":
                        var n = event.get("name") + event.get("property");
                        events.push({
                            type: SetShaderProperty,
                            step: Std.parseFloat(event.get("step")),
                            name: n,
                            value: Std.parseFloat(event.get("value"))
                        });

                        set(n, Std.parseFloat(event.get("value")));    
                    case "tweenShaderProperty":
                        var n = event.get("name") + event.get("property");
                        
                        events.push({
                            type: TweenShaderProperty,
                            step: Std.parseFloat(event.get("step")),
                            name: n,
                            value: Std.parseFloat(event.get("value")),
                            time: Std.parseFloat(event.get("time")),
                            ease: LuaUtils.getTweenEaseByString(event.get("ease")),
                            startValue: event.exists("startValue") ? Std.parseFloat(event.get("startValue")) : get(n)
                        });
    
                        //DI = Downscroll Inverse
                        if (event.exists("DI_startValue")) {
                            if (ClientPrefs.data.downScroll && event.get("DI_startValue") == "true") {
                                events[events.length-1].startValue *= -1;
                            }
                        }
                        if (event.exists("DI_value")) {
                            if (ClientPrefs.data.downScroll && event.get("DI_value") == "true") {
                                events[events.length-1].value *= -1;
                            }
                        }
    
                        if (events[events.length-1].step <= -1) {
                            events[events.length-1].step = 0;
                        }
    
                        set(n, Std.parseFloat(event.get("value")));
    
                    case "addCameraZoom" | "addHUDZoom":
                        events.push({
                            type: event.get("type") == "addCameraZoom" ? AddCameraZoom : AddHUDZoom,
                            step: Std.parseFloat(event.get("step")),
                            value: Std.parseFloat(event.get("value"))
                        });
                }
            }
        }

        events.sort(function(a, b) {
            if(a.step < b.step) return -1;
            else if(a.step > b.step) return 1;
            else return 0;
        });

        for (n => value in defaultValues) {
            set(n, value);
        }

    }
    private inline function set(n:String, value:Float) {
        if (PlayState.instance.modchartSprites.exists(n)) {
            PlayState.instance.modchartSprites.get(n).x = value;
        }
    }
    private inline function get(n:String) {
        if (PlayState.instance.modchartSprites.exists(n)) {
            return PlayState.instance.modchartSprites.get(n).x;
        }
        return 0.0;
    }
    public function updateEvents() {
        if (!ClientPrefs.data.shaders) return;
        
        var i = 0;
        var curStepFloat = PlayState.instance.curDecStep;
        for (e in events) {
            if (curStepFloat < e.step) {
                break;
            }

            if (curStepFloat >= e.step) {
                switch(e.type) {
                    case SetShaderProperty:
                        set(e.name, e.value);
                        events.remove(e);
                    case TweenShaderProperty:
                        if (curStepFloat < e.step + e.time) {
                                    
                            var l = 0 + (curStepFloat - e.step) * ((1 - 0) / ((e.step + e.time) - e.step));
                            var newValue = FlxMath.lerp(e.startValue, e.value, e.ease(l));
            
                            set(e.name, newValue);
                        } else {
                            set(e.name, e.value);
                            events.remove(e);
                        }
                    case AddCameraZoom:
                        PlayState.instance.camGame.zoom += e.value;
                        events.remove(e);
                    case AddHUDZoom:
                        PlayState.instance.camHUD.zoom += e.value;
                        events.remove(e);
                }
            }
            
        }

        for (data in iTimeShaderData) {
            if (data.hasSpeed) {
                data.iTime += (FlxG.elapsed * get(data.shaderName + "speed"));
                set(data.shaderName + "iTime", data.iTime);
            } else {
                set(data.shaderName + "iTime", Conductor.songPosition*0.001);
            }
        }
    }
}
