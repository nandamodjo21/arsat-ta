<!-- Begin Page Content -->
<div class="container-fluid">

    <!-- Page Heading -->
    <h1 class="h3 mb-4 text-gray-800"><?= $title; ?></h1>
    <?= $this->session->flashdata('pesan'); ?>
    <div class="row">
        <div class="col-lg-12">
            <!-- DataTales Example -->
            <div class="card shadow mb-4">
                <div class="card-header py-3">
                    <h6 class="m-0 font-weight-bold text-primary">Data Rekapan</h6>

                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-bordered text-center" id="dataTable" width="100%" cellspacing="0">
                            <thead>
                                <tr>
                                    <th>No</th>
                                    <th>Nama Penyewa</th>
                                    <th>Nama Barang</th>
                                    <th>Stok</th>
                                    <th>Lama Sewa Hari</th>
                                    <th>Tanggal Sewa dan Waktu</th>
                                    <th>Tanggal Kembali</th>
                                    <th>Total Bayar</th>
                                    <th>Bukti Pembayaran</th>
                                    <th>Status</th>
                                    <th>Aksi</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php $no = 1;
                                    foreach ($rekapan as $br) : ?>
                                <tr>
                                    <th><?= $no++ ?></th>
                                    <td class="text-dark"><?= $br->nama_lengkap ?></td>
                                    <td class="text-dark"><?= $br->nama_barang ?></td>
                                    <td class="text-dark"><?= $br->stok ?></td>
                                    <td class="text-dark"><?= $br->lama_sewa ?></td>
                                    <td class="text-dark"><?= $br->tgl_sewa ?></td>
                                    <td class="text-dark"><?= $br->tgl_kembali ?></td>
                                    <td class="text-dark"><?= $br->total_bayar ?></td>
                                    <th>
                                        <?php if ($br->image_path) : ?>
                                        <img src="http://localhost:8085/api/<?= $br->image_path ?>"
                                            alt="<?= $br->image_path ?>">
                                        <?php else : ?>
                                        Belum Membayar
                                        <?php endif; ?>
                                    </th>
                                    <td class="text-dark"><?= $br->status ?></td>

                                    <th>
                                        <?php if ($br->status != "Berhasil") : ?>
                                        <a href="<?= base_url() . "rekapan/setuju/" . $br->id_penyewa ?>"
                                            class="badge badge-success">Setujui</a>
                                        <?php else : ?>
                                        <!-- Tampilkan pesan atau tindakan alternatif jika status adalah 1 -->
                                        Status Sudah Disetujui
                                        <?php endif; ?>
                                    </th>
                                </tr>
                                <?php endforeach; ?>

                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- verifakasi -->


<!-- Modal setujui -->
<?php  foreach ($rekapan as $br) : ?>
<div class="modal fade" id="setujuiModal<?= $br->id_penyewa ?>" tabindex="-1" aria-labelledby="exampleModalLabel"
    aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Verifikasi</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form action="<?= base_url('rekapan/verifikasi/') . $br->id_penyewa ?>" method="post">
                <div class="modal-body">
                    <div class="form-group">
                        <input type="hidden" value="<?= $br->id_penyewa ?>" name="id" class="form-control">
                    </div>
                    Apakah anda yakin ingin menyetujui transaksi ini?
                </div>
            </form>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Keluar</button>
                <button type="submit" class="btn btn-primary">Setuju</button>
            </div>
        </div>
    </div>
</div>
<?php endforeach; ?>

<!-- modal batalkan -->

<div class="modal fade" id="batalkanModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Verifikasi</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                Apakah anda yakin ingin membatalkan transaksi ini?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline-secondary" data-dismiss="modal">Keluar</button>
                <button type="submit" class="btn btn-outline-danger">Batalkan</button>
            </div>
        </div>
    </div>
</div>