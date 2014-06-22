import mx.transitions.Tween;
import mx.transitions.easing.*;
import caurina.transitions.*;
import oxylus.vmig.main;
import oxylus.vmig.rightScroller;
class oxylus.vmig.leftScroller extends MovieClip {
	private var Title:MovieClip;
	private var Bg:MovieClip;
	private var Mask:MovieClip;
	private var lst:MovieClip;
	private var node:XMLNode;
	private var tol:Number;
	private var space:Number = 10;
	public static var menuCount:Number;

	private var totalHeight:Number = 0;

	public function Resize(myW, myH) {
		if (main.resized != 1) {
			Tweener.addTween(Bg,{_height:myH, time:.5, transition:"easeInOutQuad"});
			Tweener.addTween(Mask,{_height:myH-Title._height-2, time:.5, transition:"easeInOutQuad"});
		} else {
			Tweener.addTween(Bg,{_height:myH, time:0, transition:"easeInOutQuad"});
			Tweener.addTween(Mask,{_height:myH-Title._height-2, time:0, transition:"easeInOutQuad"});
		}
		if (lst._y<(myH-Title._height-2-lst._height) && (lst._height>(myH-Title._height-2))) {
			if (main.resized != 1) {
				Tweener.addTween(lst,{_y:(myH-Title._height-2-lst._height), time:.5, transition:"easeInOutQuad"});

			} else {
				Tweener.addTween(lst,{_y:(myH-Title._height-2-lst._height), time:0, transition:"easeInOutQuad"});


			}
		}
	}
	public function leftScroller() {
		lst = this.createEmptyMovieClip("lst", this.getNextHighestDepth());
		Mask = this["c"];
		Bg = this["bg"];
		lst.setMask(Mask);
		Title = this["title"];
		Title["txt"]["txt"].selectable = false;

	}
	public function setNode(n:XMLNode) {
		node = n;
		Title["txt"]["txt"].text = node.lastChild.attributes.MainTitle;
		buildList();
	}
	private function buildList() {

		var aux = node.firstChild.firstChild;
		var i:Number = 0;
		for (; aux != null; aux=aux.nextSibling) {
			lst.attachMovie("Button","but"+i,lst.getNextHighestDepth());
			lst["but"+i]._y = (lst["but"+i]._height-3)*i;
			lst["but"+i].setData(aux.attributes.thumb,aux.attributes.title,aux.attributes.subtitle,aux.firstChild,aux);
			lst["but"+i]._y += 27;
			lst["but"+i]._x += 1;
			lst["but"+i].nrBt = (i+1);
			i++;

		}
		tol = lst["but"+0]._height;


	}
	public function onMouseMove() {
		if ((_xmouse>0) && (_xmouse<Mask._width) && (_ymouse>0) && (_ymouse<Mask._height) && (lst._height>Mask._height)) {

			var ym:Number = _ymouse-tol;
			if (ym<0) {
				ym = 0;
			}
			if (ym>Mask._height-2*tol) {
				ym = Mask._height-2*tol;

			}
			var ypos:Number = Math.round((ym*(Mask._height-lst._height))/(Mask._height-2*tol));

			lst.onEnterFrame = function() {
				if (Math.abs(this._y-ypos)<1) {
					rightScroller.blur(0,this);
					delete this.onEnterFrame;
					this._y = ypos;
					return;
				} else {
					if (Math.abs(ypos-this._y)>20) {
						rightScroller.blur(Math.abs((ypos-this._y)/20),this);

					} else {
						rightScroller.blur(0,this);
					}
					this._y += (ypos-this._y)/3;
				}
			};

		}
	}
}