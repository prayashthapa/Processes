// Processes - Day 47
// Prayash Thapa - February 16, 2016

// ************************************************************************************

import hype.*;
import hype.extended.behavior.*;
import hype.extended.colorist.*;
import hype.extended.layout.*;
import hype.interfaces.*;
import processing.pdf.*;

boolean paused = false, record = false;
HDrawablePool pool, pool2, pool3;
HShapeLayout hsl;

HColorPool colors, colors2;
HPixelColorist pcolors;

// ************************************************************************************

void setup() {
	size(800, 800);
	H.init(this).background(#192033 ).autoClear(true);

	HImage hitObject = new HImage("map.png");
	H.add(hitObject).anchorAt(H.CENTER).locAt(H.CENTER).size(1100).visibility(false);
	hsl = new HShapeLayout().target(hitObject);

	colors = new HColorPool()
		.add(#ffff29,2) //yellow
		.add(#ffc206,6) //light orange
		.add(#ff8708,4) // dark orange
 		.add(#333399,4) //purple
		.add(#8561ff,2) //light purp
		.add(#00cccc,6) //teal
		.add(#ff58e0,2) //pink
		.add(#9f368b) //d pink
		.add(#dee7ff,12)
		.add(#455787,4)
		.add(#2f3b5c,4)
		.fillOnly()
	;

	colors2 = new HColorPool()
		.add(#ffffff)
		.add(#e7e7e7) //lightest
		.add(#B5C6D7) //v.light blue
		.add(#333333,2)
		.add(#666666)
		.add(#111111,3)
		.fillOnly()
	;

	drawThings();
}

// ************************************************************************************

void draw() {
	H.drawStage();
}

// ************************************************************************************

void drawThings() {
	H.clearStage();

	pool3 = new HDrawablePool(100);
	pool3.autoAddToStage()

		.add (new HShape("Shape 1.svg").anchorAt(H.CENTER))
		.add (new HShape("Shape 2.svg").anchorAt(H.CENTER))
		.add (new HShape("Shape 3.svg").anchorAt(H.CENTER))
		.add (new HShape("Shape 4.svg").anchorAt(H.CENTER))
		.add (new HShape("Shape 6.svg").anchorAt(H.CENTER))
		.add (new HShape("Shape 7.svg").anchorAt(H.CENTER))

		.colorist(colors2)
		.layout(hsl)

		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HShape d = (HShape) obj;
					d
						.enableStyle(false)
						.fill(#2f3b5c)
						.noStroke()
						.size((int)random(5,200))
						.rotation((int)random(0,360))
					;
				}
			}
		).requestAll();

	pool = new HDrawablePool(100);
	pool.autoAddToStage()

		.add (new HShape("Shape 1.svg").anchorAt(H.CENTER))
		.add (new HShape("Shape 2.svg").anchorAt(H.CENTER))
		.add (new HShape("Shape 3.svg").anchorAt(H.CENTER))
		.add (new HShape("Shape 4.svg").anchorAt(H.CENTER))
		.add (new HShape("Shape 6.svg").anchorAt(H.CENTER))
		.add (new HShape("Shape 7.svg").anchorAt(H.CENTER))

		.layout(hsl)

		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HShape d = (HShape) obj;
					d
						.anchorAt(H.CENTER)
						.noStroke()
						.size((int)random(30,200))
						.rotation((int)random(0,360))
					;
					 d.randomColors(colors.fillOnly());

				}
			}
		).requestAll();

	pool2 = new HDrawablePool(20);
	pool2.autoAddToStage()
		.add (new HShape("Shape 1.svg").anchorAt(H.CENTER))
		.add (new HShape("Shape 2.svg").anchorAt(H.CENTER))
		.add (new HShape("Shape 3.svg").anchorAt(H.CENTER))
		.add (new HShape("Shape 4.svg").anchorAt(H.CENTER))
		.add (new HShape("Shape 6.svg").anchorAt(H.CENTER))
		.add (new HShape("Shape 7.svg").anchorAt(H.CENTER))

		.layout(hsl)

		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HShape d = (HShape) obj;
					d
						.anchorAt(H.CENTER)
						.noStroke()
						.rotation((int)random(360))
						.size((int)random(150,600))
					;
					d.randomColors(colors.fillOnly());
				}
			}
		).requestAll();
	H.drawStage();
}

void keyPressed() {
	if (key == ']') drawThings();
	if (key == 'r') {
		record = true;
		saveFrame("render_####.png");
		saveVector();
	}
}

void saveVector() {
	PGraphics tmp = null;
	tmp = beginRecord(PDF, "render_#####.pdf");
	if (tmp == null) H.drawStage(); else H.stage().paintAll(tmp, false, 1); // PGraphics, uses3D, alpha
	endRecord();
}
