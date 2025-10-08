pragma solidity 0.8.20;

contract Struct {

    struct Games {
        string description;
        bool played;
    }

    Games[] private games;

    function get(uint _index) public view returns(Games memory){
        return games[_index];
    }

    function createGames(string memory _description) public {
        games.push(Games(_description, false));

        games.push(Games({description: _description, played: false }));

        Games memory game;

        game.description = _description;
        game.played = true;
        games.push(game);
    }

    function updateDescription(uint _index, string memory _description) public {
        Games storage game = games[_index];
        game.description = _description;
    }  

    function setOpposite(uint _index) public {
        Games storage game = games[_index];
        game.played = !game.played;
    }  
}