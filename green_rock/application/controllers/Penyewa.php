<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Penyewa extends CI_Controller
{
    function __construct()
    {
        parent::__construct();
        $this->load->model('M_penyewa');
    }
    public function index()
    {
        $data['title'] = 'Penyewa';
        $data['user'] = $this->db->get_where('t_user', ['email' => $this->session->userdata('email')])->row_array();

        // $data['penyewa'] = $this->M_penyewa->get_data();

        // $dataFromApi = 
        // $apiUrl = 'http://d417-182-1-137-147.ngrok-free.app/api/'; // Ganti dengan URL sesuai dengan REST API Anda
    
        // // Buat request cURL
        // $curl = curl_init($apiUrl);
        
        // // Konfigurasi request cURL
        // curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
        
        // // Eksekusi request
        // $data['api'] = curl_exec($curl);
        
        // // Tutup koneksi cURL
        // curl_close($curl);
        $data['penyewa'] = $this->M_penyewa->get_data();
        $this->load->view('templates/header', $data);
        $this->load->view('templates/sidebar', $data);
        $this->load->view('templates/topbar', $data);
        $this->load->view('admin/penyewa', $data);
        $this->load->view('templates/footer');
    }
    private function getDataFromApi()
    {
        // Endpoint URL dari REST API
       
    
        return $response;
        // Proses respons dari REST API
       
    }
    
    
}