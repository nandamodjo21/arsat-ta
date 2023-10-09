<?php

use Restserver\Libraries\REST_Controller;

defined('BASEPATH') or exit('No direct script access allowed');

// This can be removed if you use __autoload() in config.php OR use Modular Extensions
/** @noinspection PhpIncludeInspection */
//To Solve File REST_Controller not found
require APPPATH . 'libraries/REST_Controller.php';
require APPPATH . 'libraries/Format.php';
class Authentication extends REST_Controller
{

    public function __construct()
    {
        parent::__construct();
        $this->load->model('M_api');
    }

    public function login_post()
    {
        $email = $this->post('email');
        $password = md5($this->post('password'));
    
        $data = $this->M_api->getUser($email, $password)->row_array();
        if ($data) {
            $response = [
                'status' => true,
                'message' => 'Berhasil Login',
                'id' => $data['id_user'], // Ubah 'id' menjadi kolom yang sesuai dari tabel user
                'email' => $data['email'], // Ubah 'email' menjadi kolom yang sesuai dari tabel user
                'role' => $data['role_id'] // Ubah 'role' menjadi kolom yang sesuai dari tabel user
            ];
            $this->response($response, REST_Controller::HTTP_OK);
        } else {
            $response = [
                'status' => false,
                'message' => 'No users were found'
            ];
            $this->response($response, REST_Controller::HTTP_NOT_FOUND);
        }
    }
    

    public function register_post()
    {
        $query = array(

            'nama_lengkap' => $this->post('nama'),
            'email' => $this->post('email'),
            'no_hp' => $this->input->post('nohp'),
            'alamat' => $this->input->post('alamat'),
            'password' => md5($this->post('password')),
            'nik' =>$this->input->post('nik')
           
            

        );
        $this->db->set('id_user', 'UUID()', false);

        $data = $this->db->insert('tbl_user', $query);
        echo json_encode($data);
        if ($data) {
            return
                $this->response([
                    'status' => true,
                    'message' => 'Berhasil registrasi',
                ], REST_Controller::HTTP_OK);
        } else {
            $this->response([
                'status' => false,
                'message' => 'Can not insert user'
            ], REST_Controller::HTTP_NOT_FOUND);
        }
    }
}