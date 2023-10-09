<?php

use Restserver\Libraries\REST_Controller;

defined('BASEPATH') or exit('No direct script access allowed');

// This can be removed if you use __autoload() in config.php OR use Modular Extensions
/** @noinspection PhpIncludeInspection */
//To Solve File REST_Controller not found
require APPPATH . 'libraries/REST_Controller.php';
require APPPATH . 'libraries/Format.php';
class Sewa extends REST_Controller
{

    public function __construct()
    {
        parent::__construct();
        $this->load->model('M_api');
    }



    public function sewa_post()
    {
        $query = array(

            'id_org' => $this->post('email'),
            'nama_barang' => $this->post('nama_barang'),
            'lama_sewa' => $this->post('lama_sewa'),
            'Tgl_kembali' => $this->post('tgl_kembali'),
            'status' => "0"

        );
        $this->db->set('id_penyewa', 'UUID()', false);

        $data = $this->db->insert('t_penyewaan', $query);
        if ($data) {
            return
                $this->response([
                    'status' => true,
                    'message' => 'sukses menyewa',
                ], REST_Controller::HTTP_OK);
        } else {
            $this->response([
                'status' => false,
                'message' => 'maaf anda gagal'
            ], REST_Controller::HTTP_NOT_FOUND);
        }
    }
    public function tampil_get()
    {
        $id = $this->get('id');
        $data = $this->M_api->getSewa($id)->row_array();

        if ($data) {
            if ($data['status'] == 0) {
                return $this->response([
                    'status' => true,
                    'pesan' => "pesanan anda sedang di proses",
                    'data' => $data
                ], REST_Controller::HTTP_OK);
            } else {
                return $this->response([
                    'status' => true,
                    'pesan' => "pesanan anda bisa sudah bisa di jemput",
                    'data' => $data
                ], REST_Controller::HTTP_OK);
            }
        } else {
            return $this->response([
                'status' => false,
                'message' => 'tidak ada'
            ], REST_Controller::HTTP_NOT_FOUND);
        }
    }
    public function index_get()
    {
        $id = $this->get('id');
        $data = $this->M_api->getSewa($id)->result_array();
        if ($data) {
            return
                $this->response([
                    'status' => true,
                    'message' => 'Successfuly',
                    'data' => $data
                ], REST_Controller::HTTP_OK);
        } else {
            $this->response([
                'status' => false,
                'message' => 'No users were found'
            ], REST_Controller::HTTP_NOT_FOUND);
        }
    }
}
