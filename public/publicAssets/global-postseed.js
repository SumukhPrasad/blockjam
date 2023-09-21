var cmaze = new MazeBoard(window["jam-map"]);
workspace=window["blockly-workspace"]

function drawCanvas() {
	var c = document.getElementById("jam-canvas");
	var ctx = c.getContext("2d");
	for (let i = 0; i < cmaze.__getBoard().length; i++) {
		const row = cmaze.__getBoard()[i];
		for (let j = 0; j < row.length; j++) {
			const tile = row[j];
			
			ctx.fillStyle = [
				"white", 
				"grey", 
				"grey", 
				"lightgreen", 
				"grey", 
				"grey",
				"white", 
				"grey"][tile];
			ctx.fillRect((j*50), (i*50), 50, 50);
			if (tile==2) {
				ctx.beginPath();
				ctx.arc((j*50)+25, (i*50)+25, 10, 0, 2 * Math.PI, false);
				ctx.fillStyle = 'gray';
				ctx.fill();
				ctx.lineWidth = 5;
				ctx.strokeStyle = '#555';
				ctx.stroke();
			}
			if (tile==4) {
				ctx.beginPath();
				ctx.arc((j*50)+25, (i*50)+25, 10, 0, 2 * Math.PI, false);
				ctx.fillStyle = 'green';
				ctx.fill();
				ctx.lineWidth = 5;
				ctx.strokeStyle = '#003300';
				ctx.stroke();
			}
			if (tile==6) {
				ctx.beginPath();
				ctx.arc((j*50)+25, (i*50)+25, 10, 0, 2 * Math.PI, false);
				ctx.fillStyle = '#faa';
				ctx.fill();
				ctx.lineWidth = 5;
				ctx.strokeStyle = '#f55';
				ctx.stroke();
			}
			if (tile==7) {
				ctx.beginPath();
				ctx.arc((j*50)+25, (i*50)+25, 10, 0, 2 * Math.PI, false);
				ctx.fillStyle = 'lightgreen';
				ctx.fill();
				ctx.lineWidth = 5;
				ctx.strokeStyle = 'green';
				ctx.stroke();
			}
		}
	}
	ctx.stroke();
}

cmaze.updateCallback = drawCanvas;
drawCanvas();
window.globalMazeObject = cmaze;

let code = "";
javascriptGenerator.STATEMENT_PREFIX = 'window.highlightBlock(%1);\n';
javascriptGenerator.addReservedWords('highlightBlock');
javascriptGenerator.addReservedWords('code');
if (browser) window.LoopTrap = 10;
javascriptGenerator.INFINITE_LOOP_TRAP = 'if(--window.LoopTrap == 0) throw "Infinite loop.";\n';

function highlightBlock(id) {
     workspace.highlightBlock(id);
}

function onChange() {
     if (workspace.isDragging()) return; // Don't update while changes are happening.
     try {
          code = javascriptGenerator.workspaceToCode(workspace);
          //var jsInterpreterObj = new acorn.Interpreter(code);
          //jsInterpreterObj.run();
     } catch (_err) {
          // Happens e.g. when deleting a function that is used somewhere.
          // Blockly will quickly recover from this, so it's not a big deal.
          // Just make sure the app doesn't crash until then.
          console.log(_err);
     }
}

var runningInterval;

workspace.addChangeListener(onChange);

function execute() {
     try {
          var running = false;
          workspace.highlightBlock(null);
          var lastBlockToHighlight = null;

          var jsInterpreterObj = new Interpreter(code, (interpreter, scope) => {
               interpreter.setProperty(
                    scope, 'highlightBlock',
                         interpreter.createNativeFunction(id => {
                              id = id ? id.toString() : '';
                              running = false;
                              workspace.highlightBlock(lastBlockToHighlight);
                              lastBlockToHighlight = id;
                         })
               );
               interpreter.setProperty(
                    scope, 'dbg_print',
                         interpreter.createNativeFunction(val => {
                              val = val ? val.toString() : '';
                              console.log(val);
                         })
               );
               
               //maze fns
               interpreter.setProperty(
                    scope, 'updateHeading',
                         interpreter.createNativeFunction(val => {
                              val = val ? val : '';
                              cmaze.updateHeading(val);
                         })
               );
               interpreter.setProperty(
                    scope, 'move',
                         interpreter.createNativeFunction(val => {
                              cmaze.move(val);
                         })
               );
     
               interpreter.setProperty(
                    scope, 'path_ahead_exists',
                         interpreter.createNativeFunction(val => {
                              return cmaze.doesPathExist(0);
                         })
               );
     
               interpreter.setProperty(
                    scope, 'path_to_right_exists',
                         interpreter.createNativeFunction(val => {
                              return cmaze.doesPathExist(1);
                         })
               );
     
               interpreter.setProperty(
                    scope, 'path_to_left_exists',
                         interpreter.createNativeFunction(val => {
                              return cmaze.doesPathExist(-1);
                         })
               );
     
               interpreter.setProperty(
                    scope, 'has_reached_destination',
                         interpreter.createNativeFunction(val => {
                              return cmaze.hasFinishedMaze();
                         })
               );
          });

          runningInterval = setInterval(() => {
               running = true;
               while (running) {
                    if (!jsInterpreterObj.step()) {
                         workspace.highlightBlock(lastBlockToHighlight);
                         clearInterval(runningInterval);
                         setTimeout(() => {
                              if (cmaze.hasFinishedMaze()) {
                                   alert("Finished the maze!")
                                   document.getElementById("submission-form").submit()
                              }
                         }, 100);
                         setTimeout(() => {
                              workspace.highlightBlock(null);
                         }, 1000);
                         return;
                    }
               }
          }, 250);
     } catch (_err) {
          console.error(_err);
          window.alert('CATASTROPHIC ERROR!\n'+_err)
     }
}


function run() {
     cmaze.reset()
     execute();
}


var div=document.getElementById("canvasDiv")
var buttonsdiv = document.createElement('div');
buttonsdiv.style = "position : absolute; bottom: 0; left: 0; padding:0;"

var runbutton = document.createElement('button');
runbutton.style = "font-weight: bold; background: green; color: white; font-size: 18px;"
runbutton.innerText = "RUN"
runbutton.onclick = run;
var stopbutton = document.createElement('button');
stopbutton.style = "font-weight: bold; background: red; color: white;font-size: 18px;"
stopbutton.innerText = "STOP"
stopbutton.onclick = function () {clearInterval(runningInterval);setTimeout(() => {workspace.highlightBlock(null);}, 1000);};

buttonsdiv.appendChild(runbutton)
buttonsdiv.appendChild(stopbutton)

buttonsdiv.append("BlockJam Alpha Global Postseed")


div.appendChild(buttonsdiv)