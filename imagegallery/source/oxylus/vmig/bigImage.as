import flash.geom.*;
import flash.display.BitmapData;
import mx.transitions.Tween;
import mx.transitions.easing.*;
import caurina.transitions.*;
import mx.utils.Delegate;
import caurina.transitions.properties.ColorShortcuts;
import oxylus.vmig.Utils;
import oxylus.vmig.main;

class oxylus.vmig.bigImage extends MovieClip {
	private var Mask:MovieClip;
	private var node:XMLNode;
	private var Img:MovieClip;
	private var cStart:ColorTransform;
	private var cEnd:ColorTransform;
	private var mcl:MovieClipLoader;
	private var w:Number;
	private var h:Number;
	private var iw:Number = 0;
	private var ih:Number = 0;
	private var idx:Number = 0;
	public var onMotionEnd:Function;


	private var container:MovieClip;
	private var bg:MovieClip;
	private var loader:MovieClip;
	private var loaderTxt:MovieClip;
	private var loaderTxt2:MovieClip;
	private var loaderBg:MovieClip;
	private var image:MovieClip;
	private var aux2:Number = 0;
	private var prev:MovieClip;
	private var aux_prev:String = "";
	private var Html:MovieClip;
	public static var maskForHtml:MovieClip;
	public static var LabelHtml:MovieClip;
	private var ScrollHtml:MovieClip;
	public static var ScrollBar_:MovieClip;
	public static var ScrollStick:MovieClip;
	public static var productTitle:MovieClip;
	public static var counter:MovieClip;
	public static var tol:Number = 1;
	private var prel:MovieClip;
	public function bigImage() {

		ColorShortcuts.init();
		prel = this["pr"];
		prel._alpha = 0;
		counter = this["count"]["txt"];
		counter["txt"].selectable = false;

		Html = this["_html"];
		maskForHtml = Html["mask"];
		LabelHtml = Html["txt"];
		LabelHtml.setMask(maskForHtml);
		LabelHtml["txt"].wordWrap = true;
		LabelHtml["txt"].selectable = false;
		LabelHtml["txt"].autoSize = true;
		LabelHtml["txt"].html = true;
		ScrollHtml = Html["scrl"];
		ScrollBar_ = ScrollHtml["bar"];
		ScrollStick = ScrollHtml["stick"];

		Mask = this["mask"];
		bg = this["bg"];

		loader = this["loader"];
		loader.setMask(Mask);

		container = this["cont"];

		loaderTxt = loader["txt"]["txt"]["txt"];
		loaderTxt.selectable = false;

		loaderBg = loader["bg"];
		loaderTxt2 = loader["txt"];
		productTitle = this["descrb"];
		productTitle["txt"]["txt"].selectable = false;
		productTitle["txt"]["txt"].autoSize = true;

		_scroll();


		cStart = new ColorTransform(1, 1, 1, 1, 255, 255, 255, 0);
		cEnd = new ColorTransform(1, 1, 1, 1, 0, 0, 0, 0);
		mcl = new MovieClipLoader();
		mcl.addListener(this);

	}
	public function arrange() {
		var sw = Math.round(Stage.width-251);
		var sh = Math.round(Stage.height-100);

		var tox:Number = Math.round(sw/2-iw/2);
		var toy:Number = Math.round(sh/2-ih/2);
		iw = 640;
		ih = 480;

		Tweener.addTween(_root["GAL"]["LEFT_SCROLLER"],{_x:tox, _y:toy, time:.5, transition:"easeInOutQuad"});
		Tweener.addTween(_root["GAL"]["RIGHT_SCROLLER"],{_x:tox+iw+239-70, _y:toy+10, time:.5, transition:"easeInOutQuad"});

		_root["GAL"]["RIGHT_SCROLLER"].Resize(iw,ih);
		_root["GAL"]["LEFT_SCROLLER"].Resize(iw,ih+97);
		Tweener.addTween(productTitle["bg"],{_width:iw, time:.5, transition:"easeInOutQuad"});
		Tweener.addTween(productTitle,{_y:ih-productTitle._height, time:.5, transition:"easeInOutQuad"});

		Tweener.addTween(Html,{_y:ih+15, time:.5, transition:"easeInOutQuad"});
		Tweener.addTween(this["_html"]["mask"],{_width:iw-10, time:.5, transition:"easeInOutQuad"});
		Tweener.addTween(this["_html"]["txt"]["txt"],{_width:iw-40, time:.5, transition:"easeInOutQuad"});



		Tweener.addTween(ScrollHtml,{_x:iw-30, time:.5, transition:"easeInOutQuad"});

		Tweener.addTween(bg,{_x:-2, _y:-2, _width:iw+4, _height:ih+94, time:.5, transition:"easeInOutQuad"});
		Tweener.addTween(this,{_x:tox+241, _y:toy+4, time:.5, transition:"easeInOutQuad"});

	}
	public function setData(aux:String) {

		var mc:MovieClip = container.createEmptyMovieClip("img_"+(idx++), container.getNextHighestDepth());
		mcl.loadClip(aux,mc);
		Img._alpha = 80;

		prel._x = (Img._width-prel._width)/2;
		prel._y = (Img._height-prel._height)/2;

		loaderBg._width = Img._width;
		Mask._width = Img._width;
		Mask._height = Img._height;
		Mask._x = Img._x;
		Mask._y = Img._y;
		loaderBg._x = Img._x;
		loaderBg._y = Img._y;
		loaderBg._height = 0;
		loaderTxt2._y = Img._y-loaderTxt2._height;

		_scroll();
	}
	private function onLoadProgress(target:MovieClip, bytesLoaded:Number, bytesTotal:Number) {
		loaderBg._height = Img._height/(bytesTotal/bytesLoaded);
		loaderBg._alpha = 100/(bytesTotal/bytesLoaded);
		loaderTxt.text = Math.round(100/(bytesTotal/bytesLoaded))+"%";
		loaderTxt2._y = loaderBg._height-loaderTxt2._height;

	}
	private function onLoadStart() {
		prel._alpha = 100;
		loader._alpha = 100;
	}
	private function onLoadInit(mc:MovieClip) {
		prel._alpha = 0;
		loaderBg._height = 0;
		loaderTxt2._y = loaderBg._height-loaderTxt2._height;
		loader._alpha = 0;

		Img.removeMovieClip();
		var oldiw:Number = iw;
		var oldih:Number = ih;

		iw = mc._width;
		ih = mc._height;

		var bd:BitmapData = new BitmapData(iw, ih);
		bd.draw(mc);
		mc.removeMovieClip();
		Img = container.createEmptyMovieClip("img_"+(idx++), container.getNextHighestDepth());
		Img.attachBitmap(bd,1000,"always",true);
		main.resized = 0;
		resize();

		Img._width = oldiw;
		Img._height = oldih;

		var trans:Transform = new Transform(Img);
		trans.colorTransform = cStart;
		var sw = Math.round(Stage.width-251);
		var sh = Math.round(Stage.height-100);

		if (sw<640) {
			sw = 640;
		}
		if (sh<480) {
			sh = 480;
		}
		var tox:Number = Math.round(sw/2-iw/2);
		var toy:Number = Math.round(sh/2-ih/2);


		Tweener.addTween(_root["GAL"]["LEFT_SCROLLER"],{_x:tox, _y:toy, time:.5, transition:"easeInOutQuad"});
		Tweener.addTween(_root["GAL"]["RIGHT_SCROLLER"],{_x:tox+iw+239-70, _y:toy+10, time:.5, transition:"easeInOutQuad"});

		_root["GAL"]["RIGHT_SCROLLER"].Resize(iw,ih);
		_root["GAL"]["LEFT_SCROLLER"].Resize(iw,ih+97);
		Tweener.addTween(productTitle["bg"],{_width:iw, time:.5, transition:"easeInOutQuad"});
		Tweener.addTween(productTitle,{_y:ih-productTitle._height, time:.5, transition:"easeInOutQuad"});

		Tweener.addTween(Html,{_y:ih+15, time:.5, transition:"easeInOutQuad"});
		Tweener.addTween(this["_html"]["mask"],{_width:iw-10, time:.5, transition:"easeInOutQuad"});
		Tweener.addTween(this["_html"]["txt"]["txt"],{_width:iw-40, time:.5, transition:"easeInOutQuad"});



		Tweener.addTween(ScrollHtml,{_x:iw-30, time:.5, transition:"easeInOutQuad"});

		Tweener.addTween(bg,{_x:-2, _y:-2, _width:iw+4, _height:ih+94, time:.5, transition:"easeInOutQuad"});
		Tweener.addTween(this,{_x:tox+241, _y:toy+4, time:.5, transition:"easeInOutQuad"});
		Tweener.addTween(Img,{_width:iw, _height:ih, time:.5, transition:"easeInOutQuad"});

		Tweener.addTween(Img,{_colorTransform:cEnd, time:.5, delay:.5, transition:"easeInOutQuad", onComplete:Delegate.create(this, oc)});



	}
	private function resize() {
		Img._xscale = Img._yscale=100;
		iw = Img._width;
		ih = Img._height;

		if (iw<640 && ih<480) {
			iw = 640;
			ih = 480;
		}
		if (iw<=w && ih<=h) {
			if (main.resized == 1) {
				var sw = Math.round(Stage.width-251);
				var sh = Math.round(Stage.height-100);
				var tox:Number = Math.round(sw/2-iw/2);
				var toy:Number = Math.round(sh/2-ih/2);


				Tweener.addTween(_root["GAL"]["LEFT_SCROLLER"],{_x:tox, _y:toy, time:0, transition:"easeInOutQuad"});
				Tweener.addTween(_root["GAL"]["RIGHT_SCROLLER"],{_x:tox+iw+239-70, _y:toy+10, time:0, transition:"easeInOutQuad"});

				_root["GAL"]["RIGHT_SCROLLER"].Resize(iw,ih);
				_root["GAL"]["LEFT_SCROLLER"].Resize(iw,ih+97);
				Tweener.addTween(productTitle["bg"],{_width:iw, time:0, transition:"easeInOutQuad"});
				Tweener.addTween(productTitle,{_y:ih-productTitle._height, time:0, transition:"easeInOutQuad"});
				Tweener.addTween(Html,{_y:ih+15, time:0, transition:"easeInOutQuad"});
				Tweener.addTween(this["_html"]["mask"],{_width:iw-10, time:0, transition:"easeInOutQuad"});
				Tweener.addTween(this["_html"]["txt"]["txt"],{_width:iw-40, time:0, transition:"easeInOutQuad"});
				Tweener.addTween(ScrollHtml,{_x:iw-30, time:0, transition:"easeInOutQuad"});
				Tweener.addTween(bg,{_x:-2, _y:-2, _width:iw+4, _height:ih+94, time:0, transition:"easeInOutQuad"});
				Tweener.addTween(this,{_x:tox+241, _y:toy+4, time:0, transition:"easeInOutQuad"});
			}
			return;
		}
		Img._width = w;
		Img._yscale = Img._xscale;

		if (Img._height>h) {
			Img._height = h;
			Img._xscale = Img._yscale;
		}
		iw = Img._width;
		ih = Img._height;

		if (main.resized == 1) {
			var sw = Math.round(Stage.width-251);
			var sh = Math.round(Stage.height-100);
			var tox:Number = Math.round(sw/2-iw/2);
			var toy:Number = Math.round(sh/2-ih/2);


			Tweener.addTween(_root["GAL"]["LEFT_SCROLLER"],{_x:tox, _y:toy, time:0, transition:"easeInOutQuad"});
			Tweener.addTween(_root["GAL"]["RIGHT_SCROLLER"],{_x:tox+iw+239-70, _y:toy+10, time:0, transition:"easeInOutQuad"});

			_root["GAL"]["RIGHT_SCROLLER"].Resize(iw,ih);
			_root["GAL"]["LEFT_SCROLLER"].Resize(iw,ih+97);
			Tweener.addTween(productTitle["bg"],{_width:iw, time:0, transition:"easeInOutQuad"});
			Tweener.addTween(productTitle,{_y:ih-productTitle._height, time:0, transition:"easeInOutQuad"});
			Tweener.addTween(Html,{_y:ih+15, time:0, transition:"easeInOutQuad"});
			Tweener.addTween(this["_html"]["mask"],{_width:iw-10, time:0, transition:"easeInOutQuad"});
			Tweener.addTween(this["_html"]["txt"]["txt"],{_width:iw-40, time:0, transition:"easeInOutQuad"});
			Tweener.addTween(ScrollHtml,{_x:iw-30, time:0, transition:"easeInOutQuad"});
			Tweener.addTween(bg,{_x:-2, _y:-2, _width:iw+4, _height:ih+94, time:0, transition:"easeInOutQuad"});
			Tweener.addTween(this,{_x:tox+241, _y:toy+4, time:0, transition:"easeInOutQuad"});
		}
	}
	public function set maxw(nw:Number) {
		w = nw;
		resize();
		Img._width = iw;
		Img._height = ih;

	}
	public function set maxh(nh:Number) {
		h = nh;
		resize();
		Img._width = iw;
		Img._height = ih;

	}
	public function get maxw():Number {
		return w;
	}
	public function get maxh():Number {
		return h;
	}
	public function get width() {
		return iw;
	}
	public function get height() {
		return ih;
	}
	
	private function oc() {

		onMotionEnd.call(this);
	}
	
	
	public function _scroll() {
		ScrollBar_.onPress = function() {
			if (Math.round(LabelHtml._height)>maskForHtml._height) {
				this.startDrag(false,-3,ScrollStick._height-this._height,-3);

				this.onEnterFrame = function() {
					if (this._y>25/2) {
						if (LabelHtml._y>-(LabelHtml._height-maskForHtml._height)) {
							LabelHtml._y--;

						}
					}
					if (this._y<25/2) {
						if (LabelHtml._y != 0) {
							LabelHtml._y++;

						}
					}
				};
			}
		};
		ScrollBar_.onRelease = function() {
			if (Math.round(LabelHtml._height)>maskForHtml._height) {
				this.stopDrag();
				var tw:Tween = new Tween(this, "_y", mx.transitions.easing.Elastic.easeOut, this._y, ScrollStick._height/2-this._height/2, .2, true);

				delete this.onEnterFrame;
			}
		};
		ScrollBar_.onReleaseOutside = function() {
			this.stopDrag();
			var tw:Tween = new Tween(this, "_y", mx.transitions.easing.Elastic.easeOut, this._y, ScrollStick._height/2-this._height/2, .2, true);

			delete this.onEnterFrame;
		};
	}
	
}