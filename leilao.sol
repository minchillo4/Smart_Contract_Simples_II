pragma solidity 0.8.9;

contract leilao {
    // Parametros do leilao;
    address payable public beneficiario;    // Carteira do beneficiário, que recebera o valor do leilão
    uint public tempoEncerramentoLeilao;    // Data do encerramento do leilão em UTC em epoch time
    
    // Estado atual do leilao;
    
    address public endMaiorOferta;          // Variavel armazena o endereço com o maior valor de valorMaiorOferta
    uint public valorMaiorOferta;          //  Varivavel armazena o valor da maior oferta
    
    mapping(address => uint) public ExtornoPendente; // Mapeamento armazena que conecta endereço dos ofertantes, aos seus valores, posteriormente, o mapeamento vai ser utilizado para retirar os valores de ofertas não vencedoras 
    
    bool terminou = false;  // variavel que  armazena o estado do leilao, aberto ou fechado
    
    event aumentoMaiorOferta(address _participante, uint _valor); 
    event leilaoEncerrado(address _vencedor, uint _valor);  
    
    //
    constructor (uint tempoLeilao, address payable _participante) {  // construtor  
        beneficiario = _participante;
        tempoEncerramentoLeilao = block.timestamp + tempoLeilao;
    }
    
    function ofertar() public payable {
        require(block.timestamp <= tempoEncerramentoLeilao, "Desculpe, o leilao esta encerrado");
        require(msg.value > valorMaiorOferta && msg.value != 0, "Desculpe, sua oferta  nao e a maior.");
        valorMaiorOferta = msg.value;
        endMaiorOferta = msg.sender;
        ExtornoPendente[endMaiorOferta] += valorMaiorOferta;
        emit aumentoMaiorOferta (msg.sender, msg.value);
    }
        
    
    
    function retirar() public payable  {
        uint amount = ExtornoPendente[msg.sender];
        require(amount>0);
        payable(msg.sender).transfer(amount);
         ExtornoPendente[msg.sender] = 0;
    }
    
    function leilaoEncerrou() public {
        require(terminou = false && block.timestamp > tempoEncerramentoLeilao, "Leilao em aberto");
        terminou = true;
        emit leilaoEncerrado(endMaiorOferta, valorMaiorOferta);
        beneficiario.transfer(valorMaiorOferta);
        
        
        
    }

        
