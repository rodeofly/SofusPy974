// Generated by CoffeeScript 1.10.0
var editor, workspace;

workspace = void 0;

editor = ace.edit("editor");

editor.getSession().setUseSoftTabs(false);

editor.getSession().setMode('ace/mode/python');

$(function() {
  var divsBlockly, divsPython, loadSample;
  $.ajax({
    type: "GET",
    url: "xml/exo1-toolbox.xml",
    dataType: "xml",
    success: function(xml) {
      workspace = Blockly.inject('blocklyDiv', {
        media: "js/vendor/blockly/media/",
        zoom: {
          controls: true,
          wheel: true,
          startScale: 1.1,
          maxScale: 3,
          minScale: 0.5,
          scaleSpeed: 1.2
        },
        toolbox: $(xml).find("#toolbox")[0]
      });
      Blockly.Msg.VARIABLES_SET = 'mettre %2 dans %1';
      return Blockly.Msg.TEXT_JOIN_TITLE_CREATEWITH = 'regrouper';
    }
  });
  divsPython = "#pythonMode,  #boutons_editor";
  divsBlockly = "#blocklyMode, #boutons_blockly, .blocklyToolboxDiv";
  $(".toggleMode").on("click", function() {
    var texte;
    $(divsPython).toggle();
    $(divsBlockly).toggle();
    if ($("#pythonMode").is(":visible")) {
      texte = getPythonText();
      editor.setValue(tabuler(texte), -1);
      return editor.focus();
    }
  });
  $("#runBlocks").on("click", function() {
    return runBlockly();
  });
  $("#saveBlocks").on("click", function() {
    return sauverFichier();
  });
  $("#openBlocks").on("click", function() {
    return ouvrirClick();
  });
  $("#fileToLoad").on("change", function() {
    return ouvrirFichier();
  });
  $("#executer").on("click", function() {
    return runPython(editor);
  });
  $("#sauverFichierEdit").on("click", function() {
    return sauverFichierEdit(editor);
  });
  $("#ouvrirClickEdit").on("click", function() {
    return ouvrirClickEdit();
  });
  $("#fileToLoadEdit").on("change", function() {
    return ouvrirFichierEdit();
  });
  loadSample = function(name) {
    $(divsPython).hide();
    $(divsBlockly).show();
    workspace.clear();
    return $.ajax({
      type: "GET",
      url: "xml/" + name + ".xml",
      dataType: "xml",
      success: function(xml) {
        return Blockly.Xml.domToWorkspace($(xml).find("#" + name)[0], workspace);
      }
    });
  };
  $("#a1").on("click", function() {
    return loadSample("affect2");
  });
  $("#a2").on("click", function() {
    return loadSample("affect1");
  });
  Println('Ceci est la console de sortie');
  return Println('Les affichages "print" se feront ici');
});
