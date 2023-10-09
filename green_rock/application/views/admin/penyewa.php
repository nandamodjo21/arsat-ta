<!-- Begin Page Content -->
<div class="container-fluid">

    <!-- Page Heading -->
    <h1 class="h3 mb-4 text-gray-800"><?= $title; ?></h1>

    <div class="row">
        <div class="col-lg-12">
            <!-- DataTales Example -->
            <div class="card shadow mb-4">
                <div class="card-header py-3">
                    <h6 class="m-0 font-weight-bold text-primary">Data Penyewa</h6>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                            <thead>
                                <tr>
                                    <th>No</th>
                                    <th>Nama</th>
                                    <th>Email</th>
                                    <th>Alamat</th>
                                    <th>NIK</th>
                                    <th>Nomor HP</th>
                                    <th>Foto Ktp</th>
                                    <th>Aksi</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php $no = 1;
                                foreach ($penyewa as $br) : ?>
                                <tr>
                                    <th><?= $no++ ?></th>
                                    <th><?= $br->nama_lengkap ?></th>
                                    <th><?= $br->email ?></th>
                                    <th><?= $br->alamat ?></th>
                                    <th><?= $br->nik ?></th>
                                    <th><?= $br->no_hp ?></th>
                                    <th>
                                        <?php if ($br->image_path) : ?>
                                        <img src="http://localhost:8085/api/<?= $br->image_path ?>"
                                            alt="<?= $br->image_path ?>">
                                        <?php else : ?>
                                        Tidak Ada Gambar
                                        <?php endif; ?>
                                    </th>

                                    <th>

                                        <a href="" class="badge badge-success">active</a>

                                    </th>
                                </tr>
                            </tbody>
                            <?php endforeach; ?>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>