<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Barang extends CI_Controller
{
    function __construct()
    {
        parent::__construct();
        $this->load->model('M_barang');
    }
    public function index()
    {
        $data['title'] = 'Data Barang';
        $data['user'] = $this->db->get_where('t_user', ['email' => $this->session->userdata('email')])->row_array();

        $data['barang'] = $this->M_barang->get_data()->result();
        $data['edit'] = $this->M_barang->get_barang()->result();
        $this->load->view('templates/header', $data);
        $this->load->view('templates/sidebar', $data);
        $this->load->view('templates/topbar', $data);
        $this->load->view('admin/barang', $data);
        $this->load->view('templates/footer');
    }
    public function tambah_data()
    {
        $id = $this->input->post('nama');
        $stok = $this->input->post('stok');
        $harga = $this->input->post('harga');

        $data = array(
            'nama_barang' => $id,
            'stok_barang' => $stok,
            'harga_barang' => $harga,
        );
        $this->M_barang->insert($data, 't_barang');
        redirect('barang');
    }
    public function edit_barang()
    {
        $id = $this->input->post('id');
        $nama = $this->input->post('nama');
        $stok = $this->input->post('stok');
        $harga = $this->input->post('harga');

        $data = array(
            'nama_barang' => $nama,
            'stok_barang' => $stok,
            'harga_barang' => $harga,
        );
        $this->M_barang->edit_barang($id, 't_barang', $data);
        redirect('barang');
    }
    public function delete($id)
    {
        $this->M_barang->delete($id);
        redirect('barang');
    }
}