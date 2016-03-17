package deengames.abook.owlicious.screens;

import flixel.FlxG;
import flixel.addons.display.FlxExtendedSprite;
import flixel.input.mouse.FlxMouseEventManager;

import deengames.abook.core.Screen;

import Main;

class FindMiceScreen extends Screen {
    
    private var obstacles:Array<Obstacle> = new Array<Obstacle>();
    
    override public function create():Void
    {
        
        super.create();
        this.obstacles.push(new Obstacle("bush", 620, 150));
        this.obstacles.push(new Obstacle("bush", 760, 400));
        this.obstacles.push(new Obstacle("bush", 120, 350));
        this.obstacles.push(new Obstacle("rock", 250, 200));
        this.obstacles.push(new Obstacle("rock", 800, 250));
        
        for (o in obstacles) {
            add(o);
            FlxMouseEventManager.add(o, o.onMouseDown, o.onMouseUp);
        }
    }
    
    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
    }
}

class Obstacle extends FlxExtendedSprite
{
    public function new(type:String, x:Int, y:Int)
    {
        super(x, y);
        this.loadGraphic('assets/images/${type}.png');
        this.enableMouseDrag();
    }
    
    public function onMouseDown(me:FlxExtendedSprite):Void
    {
        this.startDrag();
    }
    
    public function onMouseUp(me:FlxExtendedSprite):Void
    {
        this.stopDrag();
    }
}