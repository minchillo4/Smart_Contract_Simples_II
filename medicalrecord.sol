pragma solidity 0.8.9;
 
contract MedicalRecord {
    
    address enderecoLaboratorio;
    string tipoDeExame;
    uint resultadoExame;
    string nomeLaboratorio;
    
    
    Patient[] public patientList;

    struct Patient {
        address enderecoPaciente;
        string nomePaciente;
        string historicoPaciente;
        }

    
    mapping(address => Patient) public acharPatient;

    //Modifier

 /*   modifier onlyLabSender() {}

    modifier onlyPatientSender() {}

*/
// Funtions

    constructor (string memory _nomeLaboratorio)  {

        enderecoLaboratorio = msg.sender;
        nomeLaboratorio = _nomeLaboratorio;
    }



    function addPatient(address _patientAddress, string memory _patientName, string memory _historicoPaciente) public  {
        patientList.push(Patient(_patientAddress, _patientName, _historicoPaciente));
       acharPatient[_patientAddress] = Patient(_patientAddress, _patientName, _historicoPaciente);
        
    }    // Adicionar pacientes para no contrato

    

/*
    function addProntuairio() {} // Criar os prontuários e Adicionar prontuários para pacientes.

    function addLaboratorio() {} // Criar labo

    function addHospital() {}
*/


}
