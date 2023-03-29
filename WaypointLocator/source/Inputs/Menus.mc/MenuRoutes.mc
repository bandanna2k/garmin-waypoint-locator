import Toybox.WatchUi;
import Toybox.Lang;
import Routes;

module Inputs { module Menus
{        
    class MenuRoutes extends Menu2
    {
        var _menuInput;
        var _routeRepository;

        function initialize(routeRepository as Repository)
        {
            Menu2.initialize({:title=>"Routes"});

            _routeRepository = routeRepository;

            addItem(new MenuItem(" Import", repositoryString(), "_mainRoutesImport", {}));
            addItem(new MenuItem(" Select", currentSelectionString(), "_mainRoutesSelect", {}));
            _menuInput = new MenuInput(new Method(self, :onSelection));
        }

        function currentSelectionString() as String 
        {
            var currentSelection = _routeRepository.currentSelection();
            return " Current: " + (currentSelection == null ? "None" : currentSelection.toString());
        }

        function repositoryString() as String
        {
            return " " + _routeRepository.repositoryUrl();
        }

        function showMenu()
        {
            WatchUi.pushView(self, _menuInput, WatchUi.SLIDE_IMMEDIATE);
        }

        function onSelection(selection as String) as Void
        {
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);

            if("_mainRoutesImport".equals(selection))
            {
                var subMenu = new MenuRouteImportFrom(_routeRepository);
                subMenu.showMenu();
                return;
            }
            if("_mainRoutesSelect".equals(selection))
            {
Logging.debug("_mainRoutesSelect");

                var subMenu = new MenuRouteSelect(_routeRepository);
                subMenu.showMenu();
                return;
            }
        }
    }
}}