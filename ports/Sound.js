function playSoundPort (elmApp) {
  elmApp.ports.playSound.subscribe(function (model) {
    var filepath = model.filepath;
    var timeout = model.timeout * 1000;
    if (filepath) {
      setTimeout(
        function () {
          new Audio(filepath).play();
        },
        timeout
      );
    }
  });
}
