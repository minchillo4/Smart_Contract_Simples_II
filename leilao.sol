pragma solidity 0.8.9;

contract leilao {
    // Parametros do leilao;
    address payable public beneficiario;
    uint public tempoEncerramentoLeilao;
    
    // Estado atual do leilao;
    
    address public endMaiorOferta;
    uint public valorMaiorOferta;
    
    mapping(address => uint) public ExtornoPendente;
    
    bool terminou = false;
    
    event aumentoMaiorOferta(address _participante, uint _valor);
    event leilaoEncerrado(address _vencedor, uint _valor);  
    
    //
    constructor (uint tempoLeilao, address payable _participante) {
        beneficiario = _participante;
        tempoEncerramentoLeilao = block.timestamp + tempoLeilao;
    }
    
    function ofertar() public payable {
        require(block.timestamp <= tempoEncerramentoLeilao, "Desculpe, o leilao esta encerrado");
        require(msg.value > valorMaiorOferta && msg.value != 0, "Desculpe, sua oferta  nao e a maior.");
        
        ExtornoPendente[endMaiorOferta] += valorMaiorOferta;
        valorMaiorOferta = msg.value;
        endMaiorOferta = msg.sender;
        emit aumentoMaiorOferta (msg.sender, msg.value);
    }
        
    
    
    function retirar() public returns (bool) {
        uint amount = ExtornoPendente[msg.sender];
        require(amount>0);
            ExtornoPendente[msg.sender] = 0;
            
            if(!payable(msg.sender).send(amount)){
                ExtornoPendente[msg.sender] = amount;
                return false;
            }
            return true;
    }
    
    function leilaoEncerrou() public {
        require(terminou = true && block.timestamp > tempoEncerramentoLeilao, "Leilao em aberto");
        terminou = true;
        emit leilaoEncerrado(endMaiorOferta, valorMaiorOferta);
        beneficiario.transfer(valorMaiorOferta);
        
        
        
    }

        

    
}
