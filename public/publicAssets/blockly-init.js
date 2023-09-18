const toolbox = {
     "kind": "flyoutToolbox",
     "contents": [
       {
         "kind": "block",
         "type": "controls_if"
       },
       {
         "kind": "block",
         "type": "controls_repeat_ext"
       },
       {
         "kind": "block",
         "type": "logic_compare"
       },
       {
         "kind": "block",
         "type": "math_number"
       },
       {
         "kind": "block",
         "type": "math_arithmetic"
       },
       {
         "kind": "block",
         "type": "text"
       },
       {
         "kind": "block",
         "type": "text_print"
       },
     ]
   }

const workspaceConfiguration = {
     toolbox: toolbox,
     collapse : false, 
     comments : true, 
     disable : true, 
     maxBlocks : Infinity, 
     trashcan : true, 
     horizontalLayout : true, 
     toolboxPosition : 'end',
     renderer: "zelos",
     theme: "zelos",
     grid : {
          spacing : 20, 
          length : 3, 
          colour : '#ddd', 
          snap : true
     }, 
     zoom : {
          controls : true, 
          wheel : true, 
          startScale : 1, 
          maxScale : 3, 
          minScale : 0.3, 
          scaleSpeed : 1.2
     }
}

const workspace = Blockly.inject('blocklyDiv', workspaceConfiguration);