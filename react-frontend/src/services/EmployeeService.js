import axios from 'axios';

const EMPLOYEE_API_BASE_URL = "/api/v1/employees";

class EmployeeService {

    getEmployees(){
        return axios.get(process.env.REACT_APP_API_HOST + EMPLOYEE_API_BASE_URL);
    }

    createEmployee(employee){
        return axios.post(process.env.REACT_APP_API_HOST + EMPLOYEE_API_BASE_URL, employee);
    }

    getEmployeeById(employeeId){
        return axios.get(process.env.REACT_APP_API_HOST + EMPLOYEE_API_BASE_URL + '/' + employeeId);
    }

    updateEmployee(employee, employeeId){
        return axios.put(process.env.REACT_APP_API_HOST + EMPLOYEE_API_BASE_URL + '/' + employeeId, employee);
    }

    deleteEmployee(employeeId){
        return axios.delete(process.env.REACT_APP_API_HOST + EMPLOYEE_API_BASE_URL + '/' + employeeId);
    }
}

export default new EmployeeService()