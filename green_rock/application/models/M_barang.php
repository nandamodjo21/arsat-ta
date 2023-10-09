<?php
defined('BASEPATH') or exit('No direct script access allowed');

class M_barang extends CI_Model
{
    public function get_data()
    {
        return $this->db->query("SELECT id, nama_barang, stok_barang, CONCAT('Rp.', FORMAT(harga_barang,0)) as harga_barang from t_barang");
    }
    public function get_barang()
    {
        return $this->db->query("SELECT id, nama_barang, stok_barang,harga_barang from t_barang");
    }
    function insert($data, $tabel)
    {
        $this->db->insert($tabel, $data);
    }
    public function edit_barang($id, $tabel, $data)
    {
        $this->db->where('id', $id);
        $this->db->update($tabel, $data);
    }
    public function delete($id)
    {
        $this->db->where('id', $id);
        $this->db->delete('t_barang');
    }
}