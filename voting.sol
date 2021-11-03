pragma solidity 0.8.9;

contract Votacao {
    
    // VARIÁVEIS
    struct voto {
        address enderecoEleitor;
        bool escolha;
    }
    
    struct eleitor {
        string nomeEleitor;
        bool votado;
        bool existe;
    }
    
    uint private contarResultado = 0;
    uint public resultadoFinal = 0;
    uint public totalEleitores = 0;
    uint public totalVotos = 0;
    
    address enderecoOficialVotacao;
    string public nomeOficialVotacao;
    string public proposta;
    
    mapping(uint => voto) private votos;
    mapping(address => eleitor) public registroEleitores;
    
    enum Estado {Criada, Votando, Finalizado}
    Estado public estado;
    
    // MODIFIERS
    
    modifier condicao (bool _condicao) {
        require(_condicao);
        _;
    }
    
    modifier apenasOficial() {
        require(msg.sender == enderecoOficialVotacao);
        _;
    }
    
    modifier estadoAtual(Estado _estado) {
        require(estado == _estado);
        _;
    }
    
    // EVENTOS
    
    //FUNÇÕES
    
    constructor(
        string memory _nomeOficialVotacao,
        string memory _proposta
        )
        {
            nomeOficialVotacao = _nomeOficialVotacao;
            proposta = _proposta;
            estado = Estado.Criada;
            enderecoOficialVotacao = msg.sender;
        }
    
    function AddEleitor(address _voterAddress, string memory _voterName)
        public
        estadoAtual(Estado.Criada)
        apenasOficial
    {
        eleitor memory e;
        e.nomeEleitor = _voterName;
        e.votado = false;
        e.existe = true;
        registroEleitores[_voterAddress] = e;
        totalEleitores++;
    }
        
    function comecarVotacao()
        public
        estadoAtual(Estado.Criada)
        apenasOficial
        {
            estado = Estado.Votando;
        }
        
    function votar (bool _escolha) 
        public
        estadoAtual(Estado.Votando)
        returns(bool _votado)
       
    {
         bool confirmar = false;
         
         if (bytes(registroEleitores[msg.sender].nomeEleitor).length != 0
         && !registroEleitores[msg.sender].votado) {
             registroEleitores[msg.sender].votado = true;
             voto memory v;
             v.enderecoEleitor = msg.sender;
             v.escolha = _escolha;
             if(_escolha) {
                 contarResultado++;
             }
             votos[totalVotos] = v;
             totalVotos++;
             confirmar = true;
         }
         return(confirmar);
             
             
            
    }
    
    function terminarVotacao()
        public
        estadoAtual(Estado.Votando)
        apenasOficial
        {
            estado = Estado.Finalizado;
            resultadoFinal = contarResultado;
        }
        
        
            
            
 }
    
        
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
        
