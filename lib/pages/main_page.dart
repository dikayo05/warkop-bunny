import 'package:flutter/material.dart';

// Data Models
class Product {
  String id;
  String name;
  String category;
  double price;
  int stock;
  String unit;
  String description;
  DateTime createdAt;
  String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.stock,
    required this.unit,
    required this.description,
    required this.createdAt,
    this.imageUrl = '',
  });
}

class RawMaterial {
  String id;
  String name;
  String supplier;
  int stock;
  String unit;
  int minStock;
  double price;
  DateTime lastRestocked;
  DateTime expiryDate;

  RawMaterial({
    required this.id,
    required this.name,
    required this.supplier,
    required this.stock,
    required this.unit,
    required this.minStock,
    required this.price,
    required this.lastRestocked,
    required this.expiryDate,
  });
}

class Sale {
  String id;
  String productId;
  String productName;
  int quantity;
  double unitPrice;
  double totalPrice;
  DateTime saleDate;
  String customerName;
  String paymentMethod;

  Sale({
    required this.id,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    required this.saleDate,
    required this.customerName,
    required this.paymentMethod,
  });
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _fabAnimationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  late Animation<double> _fabAnimation;

  // Data Collections
  List<Product> products = [];
  List<RawMaterial> rawMaterials = [];
  List<Sale> sales = [];

  // Statistics
  int get totalProducts => products.length;
  int get lowStockProducts => products.where((p) => p.stock <= 10).length;
  int get totalRawMaterials => rawMaterials.length;
  int get lowStockMaterials => rawMaterials.where((m) => m.stock <= m.minStock).length;
  double get todaySales => sales
      .where((s) => _isSameDay(s.saleDate, DateTime.now()))
      .fold(0.0, (sum, s) => sum + s.totalPrice);
  int get todayOrders => sales
      .where((s) => _isSameDay(s.saleDate, DateTime.now()))
      .length;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _initializeSampleData();
    _animationController.forward();
    _fabAnimationController.forward();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    
    _fabAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<double>(begin: 50.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );

    _fabAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fabAnimationController, curve: Curves.elasticOut),
    );
  }

  void _initializeSampleData() {
    // Sample Products
    products = [
      Product(
        id: '1',
        name: 'Kopi Hitam',
        category: 'Minuman Panas',
        price: 8000,
        stock: 50,
        unit: 'gelas',
        description: 'Kopi hitam original dengan biji pilihan',
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
      ),
      Product(
        id: '2',
        name: 'Es Kopi Susu',
        category: 'Minuman Dingin',
        price: 12000,
        stock: 8,
        unit: 'gelas',
        description: 'Perpaduan kopi dan susu segar dengan es',
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
      ),
      Product(
        id: '3',
        name: 'Mie Ayam',
        category: 'Makanan',
        price: 15000,
        stock: 25,
        unit: 'porsi',
        description: 'Mie ayam dengan topping lengkap',
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
      Product(
        id: '4',
        name: 'Nasi Goreng',
        category: 'Makanan',
        price: 18000,
        stock: 30,
        unit: 'porsi',
        description: 'Nasi goreng spesial dengan telur',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
      Product(
        id: '5',
        name: 'Teh Manis',
        category: 'Minuman Panas',
        price: 5000,
        stock: 5,
        unit: 'gelas',
        description: 'Teh manis hangat tradisional',
        createdAt: DateTime.now(),
      ),
    ];

    // Sample Raw Materials
    rawMaterials = [
      RawMaterial(
        id: '1',
        name: 'Kopi Arabica',
        supplier: 'CV Kopi Nusantara',
        stock: 50,
        unit: 'kg',
        minStock: 20,
        price: 85000,
        lastRestocked: DateTime.now().subtract(const Duration(days: 3)),
        expiryDate: DateTime.now().add(const Duration(days: 180)),
      ),
      RawMaterial(
        id: '2',
        name: 'Gula Pasir',
        supplier: 'Toko Sembako Jaya',
        stock: 15,
        unit: 'kg',
        minStock: 25,
        price: 14000,
        lastRestocked: DateTime.now().subtract(const Duration(days: 7)),
        expiryDate: DateTime.now().add(const Duration(days: 365)),
      ),
      RawMaterial(
        id: '3',
        name: 'Susu Kental Manis',
        supplier: 'Distributor Susu',
        stock: 40,
        unit: 'kaleng',
        minStock: 20,
        price: 8500,
        lastRestocked: DateTime.now().subtract(const Duration(days: 2)),
        expiryDate: DateTime.now().add(const Duration(days: 120)),
      ),
      RawMaterial(
        id: '4',
        name: 'Telur Ayam',
        supplier: 'Peternakan Segar',
        stock: 8,
        unit: 'kg',
        minStock: 15,
        price: 28000,
        lastRestocked: DateTime.now().subtract(const Duration(days: 1)),
        expiryDate: DateTime.now().add(const Duration(days: 14)),
      ),
    ];

    // Sample Sales
    sales = [
      Sale(
        id: '1',
        productId: '1',
        productName: 'Kopi Hitam',
        quantity: 5,
        unitPrice: 8000,
        totalPrice: 40000,
        saleDate: DateTime.now().subtract(const Duration(hours: 2)),
        customerName: 'Budi Santoso',
        paymentMethod: 'Tunai',
      ),
      Sale(
        id: '2',
        productId: '2',
        productName: 'Es Kopi Susu',
        quantity: 3,
        unitPrice: 12000,
        totalPrice: 36000,
        saleDate: DateTime.now().subtract(const Duration(hours: 1)),
        customerName: 'Siti Aminah',
        paymentMethod: 'Transfer',
      ),
      Sale(
        id: '3',
        productId: '3',
        productName: 'Mie Ayam',
        quantity: 2,
        unitPrice: 15000,
        totalPrice: 30000,
        saleDate: DateTime.now().subtract(const Duration(minutes: 30)),
        customerName: 'Ahmad Rizki',
        paymentMethod: 'Tunai',
      ),
    ];
  }

  @override
  void dispose() {
    _animationController.dispose();
    _fabAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F5F1),
      appBar: _buildAppBar(),
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, _slideAnimation.value),
            child: Opacity(
              opacity: _fadeAnimation.value,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(isTablet ? 24 : 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildWelcomeSection(),
                    const SizedBox(height: 24),
                    _buildStatsGrid(isTablet),
                    const SizedBox(height: 24),
                    _buildQuickActions(isTablet),
                    const SizedBox(height: 24),
                    _buildMainMenuGrid(context, isTablet),
                    const SizedBox(height: 24),
                    _buildRecentActivity(),
                    const SizedBox(height: 100), // Space for FAB
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: _buildAnimatedFAB(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: const Color(0xFF8B4513),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF8B4513), Color(0xFFA0522D)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(
              Icons.local_cafe,
              color: Color(0xFF8B4513),
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Warkop Bunny',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Sistem Manajemen Terpadu',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () => _showNotifications(context),
          icon: Stack(
            children: [
              const Icon(Icons.notifications_outlined, color: Colors.white, size: 26),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF6B35),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                  child: Text(
                    '${lowStockProducts + lowStockMaterials}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () => _showProfileMenu(context),
          icon: const CircleAvatar(
            radius: 14,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.person,
              color: Color(0xFF8B4513),
              size: 18,
            ),
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildWelcomeSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF8B4513), Color(0xFFA0522D), Color(0xFFCD853F)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF8B4513).withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Selamat Datang Kembali!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'ONLINE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Pengelolaan bisnis Warkop Bunny mudah dan efisien',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            child: Row(
              children: [
                const Icon(Icons.calendar_today, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                Text(
                  _getCurrentDateString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                const Icon(Icons.access_time, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                Text(
                  _getCurrentTimeString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid(bool isTablet) {
    final crossAxisCount = isTablet ? 6 : 2;
    // Perbaiki aspect ratio untuk mencegah overflow
    final aspectRatio = isTablet ? 0.9 : 1.1;
    
    return GridView.count(
      crossAxisCount: crossAxisCount,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: aspectRatio, // Aspect ratio yang lebih baik
      children: [
        _buildStatCard(
          'Total Produk',
          totalProducts.toString(),
          Icons.restaurant_menu,
          const Color(0xFF2E8B57),
          'items',
        ),
        _buildStatCard(
          isTablet ? 'Stok Rendah Produk' : 'Stok Rendah',
          lowStockProducts.toString(),
          Icons.warning_amber,
          const Color(0xFFFF8C00),
          'items',
        ),
        _buildStatCard(
          isTablet ? 'Total Bahan Baku' : 'Bahan Baku',
          totalRawMaterials.toString(),
          Icons.inventory_2,
          const Color(0xFF4682B4),
          'items',
        ),
        _buildStatCard(
          'Perlu Restok',
          lowStockMaterials.toString(),
          Icons.priority_high,
          const Color(0xFFDC143C),
          'items',
        ),
        _buildStatCard(
          isTablet ? 'Penjualan Hari Ini' : 'Penjualan',
          _formatCurrency(todaySales),
          Icons.trending_up,
          const Color(0xFF32CD32),
          '',
        ),
        _buildStatCard(
          isTablet ? 'Pesanan Hari Ini' : 'Pesanan',
          todayOrders.toString(),
          Icons.receipt_long,
          const Color(0xFF9370DB),
          'orders',
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color, String suffix) {
    return Container(
      padding: const EdgeInsets.all(12), // Kurangi padding
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(color: color.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribusi ruang yang merata
        children: [
          // Header dengan icon dan trend arrow
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 20), // Ukuran icon lebih kecil
              ),
              const Spacer(),
              Icon(Icons.trending_up, color: color.withOpacity(0.6), size: 14), // Icon trend lebih kecil
            ],
          ),
          
          // Content area yang flexible
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Value dengan FittedBox untuk mencegah overflow
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    value,
                    style: TextStyle(
                      fontSize: 18, // Font size yang lebih kecil
                      fontWeight: FontWeight.bold,
                      color: color,
                      height: 1.0,
                    ),
                    maxLines: 1,
                  ),
                ),
                
                const SizedBox(height: 4),
                
                // Title dengan overflow handling
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 11, // Font size yang lebih kecil
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                    height: 1.1,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          
          // Suffix di bagian bawah jika ada
          if (suffix.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                suffix,
                style: TextStyle(
                  fontSize: 9,
                  color: color.withOpacity(0.7),
                  fontWeight: FontWeight.w400,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(bool isTablet) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Aksi Cepat',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2D3748),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 80,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildQuickActionButton(
                'Tambah Produk',
                Icons.add_box,
                const Color(0xFF2E8B57),
                () => _showProductForm(context),
              ),
              _buildQuickActionButton(
                'Catat Penjualan',
                Icons.point_of_sale,
                const Color(0xFF4682B4),
                () => _showSaleForm(context),
              ),
              _buildQuickActionButton(
                'Bahan Baku',
                Icons.inventory,
                const Color(0xFFFF8C00),
                () => _showRawMaterialForm(context),
              ),
              _buildQuickActionButton(
                'Lihat Laporan',
                Icons.analytics,
                const Color(0xFF9370DB),
                () => _showReportsDialog(context),
              ),
              _buildQuickActionButton(
                'Backup Data',
                Icons.backup,
                const Color(0xFF8B4513),
                () => _showBackupDialog(context),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActionButton(String title, IconData icon, Color color, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 120,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withOpacity(0.3)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(height: 6),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainMenuGrid(BuildContext context, bool isTablet) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width;
        final crossAxisCount = isTablet ? 3 : 2;
        
        // Hitung ukuran card berdasarkan lebar layar
        final cardWidth = (screenWidth - 48 - (crossAxisCount - 1) * 16) / crossAxisCount;
        final cardHeight = cardWidth * 0.85; // Aspect ratio 0.85 untuk lebih tinggi
        
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Menu Utama',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D3748),
              ),
            ),
            const SizedBox(height: 16),
            GridView.count(
              crossAxisCount: crossAxisCount,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: cardWidth / cardHeight, // Gunakan ratio yang dihitung
              children: [
                _buildMenuCard(
                  'Manajemen Stok Produk',
                  'Kelola menu makanan, minuman, dan produk lainnya',
                  Icons.restaurant_menu,
                  const Color(0xFF2E8B57),
                  () => _navigateToProductStock(context),
                  cardWidth,
                ),
                _buildMenuCard(
                  'Stok Bahan Baku',
                  'Monitor bahan baku dan supplies warkop',
                  Icons.inventory_2,
                  const Color(0xFF4682B4),
                  () => _navigateToRawMaterials(context),
                  cardWidth,
                ),
                _buildMenuCard(
                  'Pencatatan Penjualan',
                  'Catat transaksi dan kelola penjualan harian',
                  Icons.point_of_sale,
                  const Color(0xFFFF8C00),
                  () => _navigateToSalesRecord(context),
                  cardWidth,
                ),
                _buildMenuCard(
                  'Laporan & Analisis',
                  'Lihat laporan keuangan dan analisis bisnis',
                  Icons.analytics,
                  const Color(0xFF9370DB),
                  () => _showReportsDialog(context),
                  cardWidth,
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildMenuCard(String title, String subtitle, IconData icon, Color color, VoidCallback onTap, double cardWidth) {
    // Hitung ukuran responsif berdasarkan lebar card
    final iconSize = (cardWidth * 0.15).clamp(20.0, 28.0);
    final titleFontSize = (cardWidth * 0.08).clamp(12.0, 16.0);
    final subtitleFontSize = (cardWidth * 0.06).clamp(10.0, 12.0);
    final padding = (cardWidth * 0.1).clamp(12.0, 20.0);
    
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(color: color.withOpacity(0.1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, // Penting: gunakan mainAxisSize.min
          children: [
            // Header dengan icon dan arrow
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(padding * 0.6),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: color, size: iconSize),
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  color: color.withOpacity(0.6),
                  size: 12,
                ),
              ],
            ),
            
            SizedBox(height: padding * 0.7),
            
            // Title
            Text(
              title,
              style: TextStyle(
                fontSize: titleFontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF2D3748),
                height: 1.1,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            
            SizedBox(height: padding * 0.3),
            
            // Subtitle dengan batasan tinggi yang jelas
            Expanded(
              child: Text(
                subtitle,
                style: TextStyle(
                  fontSize: subtitleFontSize,
                  color: Colors.grey,
                  height: 1.2,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Aktivitas Terbaru',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D3748),
              ),
            ),
            TextButton.icon(
              onPressed: () => _showAllActivity(context),
              icon: const Icon(Icons.visibility, size: 16),
              label: const Text('Lihat Semua'),
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF8B4513),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildActivityItem(
                'Produk "${products.isNotEmpty ? products.last.name : 'Unknown'}" ditambahkan',
                '5 menit yang lalu',
                Icons.add_circle,
                const Color(0xFF2E8B57),
              ),
              if (sales.isNotEmpty)
                _buildActivityItem(
                  'Penjualan ${sales.last.productName} (${sales.last.quantity} ${_getProductUnit(sales.last.productId)})',
                  _getTimeAgo(sales.last.saleDate),
                  Icons.shopping_cart,
                  const Color(0xFF4682B4),
                ),
              if (lowStockMaterials > 0)
                _buildActivityItem(
                  'Ada $lowStockMaterials bahan baku perlu restok!',
                  '1 jam yang lalu',
                  Icons.warning_amber,
                  const Color(0xFFFF8C00),
                ),
              _buildActivityItem(
                'Laporan harian berhasil dibuat',
                '2 jam yang lalu',
                Icons.description,
                const Color(0xFF9370DB),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActivityItem(String title, String time, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2D3748),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: Colors.grey.withOpacity(0.5),
            size: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedFAB() {
    return ScaleTransition(
      scale: _fabAnimation,
      child: FloatingActionButton.extended(
        onPressed: () => _showQuickActionsModal(context),
        backgroundColor: const Color(0xFF8B4513),
        elevation: 8,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          'Quick Action',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }

  // Navigation Methods
  void _navigateToProductStock(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => _buildProductManagementModal(),
    );
  }

  void _navigateToRawMaterials(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => _buildRawMaterialsModal(),
    );
  }

  void _navigateToSalesRecord(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => _buildSalesRecordModal(),
    );
  }

  // Helper Methods
  String _getCurrentDateString() {
    final now = DateTime.now();
    final days = ['Minggu', 'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu'];
    final months = ['Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni', 
                   'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'];
    return '${days[now.weekday % 7]}, ${now.day} ${months[now.month - 1]} ${now.year}';
  }

  String _getCurrentTimeString() {
    final now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
  }

  String _formatCurrency(double amount) {
    if (amount >= 1000000) {
      return 'Rp ${(amount / 1000000).toStringAsFixed(1)}M';
    } else if (amount >= 1000) {
      return 'Rp ${(amount / 1000).toStringAsFixed(0)}K';
    }
    return 'Rp ${amount.toStringAsFixed(0)}';
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
           date1.month == date2.month &&
           date1.day == date2.day;
  }

  String _getProductUnit(String productId) {
    try {
      return products.firstWhere((p) => p.id == productId).unit;
    } catch (e) {
      return 'item';
    }
  }

  String _getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} menit yang lalu';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} jam yang lalu';
    } else {
      return '${difference.inDays} hari yang lalu';
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  String _formatDateTime(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }

  // CRUD Operations for Products
  void _addProduct(Product product) {
    setState(() {
      products.add(product);
    });
    _showSuccessSnackBar('Produk berhasil ditambahkan');
  }

  void _updateProduct(Product updatedProduct) {
    setState(() {
      final index = products.indexWhere((p) => p.id == updatedProduct.id);
      if (index != -1) {
        products[index] = updatedProduct;
      }
    });
    _showSuccessSnackBar('Produk berhasil diperbarui');
  }

  void _deleteProduct(String productId) {
    setState(() {
      products.removeWhere((p) => p.id == productId);
    });
    _showSuccessSnackBar('Produk berhasil dihapus');
  }

  // CRUD Operations for Raw Materials
  void _addRawMaterial(RawMaterial material) {
    setState(() {
      rawMaterials.add(material);
    });
    _showSuccessSnackBar('Bahan baku berhasil ditambahkan');
  }

  void _updateRawMaterial(RawMaterial updatedMaterial) {
    setState(() {
      final index = rawMaterials.indexWhere((m) => m.id == updatedMaterial.id);
      if (index != -1) {
        rawMaterials[index] = updatedMaterial;
      }
    });
    _showSuccessSnackBar('Bahan baku berhasil diperbarui');
  }

  void _deleteRawMaterial(String materialId) {
    setState(() {
      rawMaterials.removeWhere((m) => m.id == materialId);
    });
    _showSuccessSnackBar('Bahan baku berhasil dihapus');
  }

  // CRUD Operations for Sales
  void _addSale(Sale sale) {
    setState(() {
      sales.add(sale);
      // Update product stock
      final productIndex = products.indexWhere((p) => p.id == sale.productId);
      if (productIndex != -1) {
        products[productIndex].stock -= sale.quantity;
      }
    });
    _showSuccessSnackBar('Penjualan berhasil dicatat');
  }

  void _updateSale(Sale updatedSale) {
    setState(() {
      final index = sales.indexWhere((s) => s.id == updatedSale.id);
      if (index != -1) {
        sales[index] = updatedSale;
      }
    });
    _showSuccessSnackBar('Data penjualan berhasil diperbarui');
  }

  void _deleteSale(String saleId) {
    setState(() {
      final saleToDelete = sales.firstWhere((s) => s.id == saleId);
      // Restore product stock
      final productIndex = products.indexWhere((p) => p.id == saleToDelete.productId);
      if (productIndex != -1) {
        products[productIndex].stock += saleToDelete.quantity;
      }
      sales.removeWhere((s) => s.id == saleId);
    });
    _showSuccessSnackBar('Data penjualan berhasil dihapus');
  }

  // UI Components for CRUD Operations
  Widget _buildProductManagementModal() {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    const Icon(Icons.restaurant_menu, color: Color(0xFF2E8B57), size: 28),
                    const SizedBox(width: 12),
                    const Text(
                      'Manajemen Stok Produk',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    FloatingActionButton.small(
                      onPressed: () => _showProductForm(context),
                      backgroundColor: const Color(0xFF2E8B57),
                      child: const Icon(Icons.add, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: products.isEmpty
                    ? _buildEmptyState('Belum ada produk', 'Tambahkan produk pertama Anda')
                    : ListView.builder(
                        controller: scrollController,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return _buildProductCard(product);
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProductCard(Product product) {
    final isLowStock = product.stock <= 10;
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2E8B57).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    _getCategoryIcon(product.category),
                    color: const Color(0xFF2E8B57),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        product.category,
                        style: const TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                PopupMenuButton(
                  onSelected: (value) {
                    switch (value) {
                      case 'edit':
                        _showProductForm(context, product: product);
                        break;
                      case 'delete':
                        _showDeleteConfirmation(
                          context,
                          'Hapus Produk',
                          'Apakah Anda yakin ingin menghapus ${product.name}?',
                          () => _deleteProduct(product.id),
                        );
                        break;
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(Icons.edit, size: 20),
                          SizedBox(width: 8),
                          Text('Edit'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete, color: Colors.red, size: 20),
                          SizedBox(width: 8),
                          Text('Hapus', style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              product.description,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Harga', style: TextStyle(fontSize: 12, color: Colors.grey)),
                      Text(
                        'Rp ${product.price.toStringAsFixed(0)}',
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Stok', style: TextStyle(fontSize: 12, color: Colors.grey)),
                      Row(
                        children: [
                          Text(
                            '${product.stock} ${product.unit}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: isLowStock ? Colors.red : Colors.black,
                            ),
                          ),
                          if (isLowStock) ...[
                            const SizedBox(width: 4),
                            const Icon(Icons.warning, color: Colors.red, size: 16),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (isLowStock) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'Stok Rendah!',
                  style: TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildRawMaterialsModal() {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    const Icon(Icons.inventory_2, color: Color(0xFF4682B4), size: 28),
                    const SizedBox(width: 12),
                    const Text(
                      'Stok Bahan Baku',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    FloatingActionButton.small(
                      onPressed: () => _showRawMaterialForm(context),
                      backgroundColor: const Color(0xFF4682B4),
                      child: const Icon(Icons.add, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: rawMaterials.isEmpty
                    ? _buildEmptyState('Belum ada bahan baku', 'Tambahkan bahan baku pertama Anda')
                    : ListView.builder(
                        controller: scrollController,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: rawMaterials.length,
                        itemBuilder: (context, index) {
                          final material = rawMaterials[index];
                          return _buildRawMaterialCard(material);
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRawMaterialCard(RawMaterial material) {
    final isLowStock = material.stock <= material.minStock;
    final isExpiringSoon = material.expiryDate.difference(DateTime.now()).inDays <= 30;
    
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4682B4).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.inventory, color: Color(0xFF4682B4)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        material.name,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        material.supplier,
                        style: const TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                PopupMenuButton(
                  onSelected: (value) {
                    switch (value) {
                      case 'edit':
                        _showRawMaterialForm(context, material: material);
                        break;
                      case 'delete':
                        _showDeleteConfirmation(
                          context,
                          'Hapus Bahan Baku',
                          'Apakah Anda yakin ingin menghapus ${material.name}?',
                          () => _deleteRawMaterial(material.id),
                        );
                        break;
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(Icons.edit, size: 20),
                          SizedBox(width: 8),
                          Text('Edit'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete, color: Colors.red, size: 20),
                          SizedBox(width: 8),
                          Text('Hapus', style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Stok Saat Ini', style: TextStyle(fontSize: 12, color: Colors.grey)),
                      Row(
                        children: [
                          Text(
                            '${material.stock} ${material.unit}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: isLowStock ? Colors.red : Colors.black,
                            ),
                          ),
                          if (isLowStock) ...[
                            const SizedBox(width: 4),
                            const Icon(Icons.warning, color: Colors.red, size: 16),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Min. Stok', style: TextStyle(fontSize: 12, color: Colors.grey)),
                      Text(
                        '${material.minStock} ${material.unit}',
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Harga', style: TextStyle(fontSize: 12, color: Colors.grey)),
                      Text(
                        'Rp ${material.price.toStringAsFixed(0)}',
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Kadaluarsa', style: TextStyle(fontSize: 12, color: Colors.grey)),
                      Text(
                        _formatDate(material.expiryDate),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: isExpiringSoon ? Colors.orange : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (isLowStock || isExpiringSoon) ...[
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  if (isLowStock)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'Perlu Restok!',
                        style: TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                    ),
                  if (isExpiringSoon)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'Segera Kadaluarsa',
                        style: TextStyle(color: Colors.orange, fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSalesRecordModal() {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    const Icon(Icons.point_of_sale, color: Color(0xFFFF8C00), size: 28),
                    const SizedBox(width: 12),
                    const Text(
                      'Pencatatan Penjualan',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    FloatingActionButton.small(
                      onPressed: () => _showSaleForm(context),
                      backgroundColor: const Color(0xFFFF8C00),
                      child: const Icon(Icons.add, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: sales.isEmpty
                    ? _buildEmptyState('Belum ada penjualan', 'Catat penjualan pertama Anda')
                    : ListView.builder(
                        controller: scrollController,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: sales.length,
                        itemBuilder: (context, index) {
                          final sale = sales[sales.length - 1 - index]; // Show newest first
                          return _buildSaleCard(sale);
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSaleCard(Sale sale) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF8C00).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.shopping_cart, color: Color(0xFFFF8C00)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        sale.productName,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        sale.customerName,
                        style: const TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                PopupMenuButton(
                  onSelected: (value) {
                    switch (value) {
                      case 'edit':
                        _showSaleForm(context, sale: sale);
                        break;
                      case 'delete':
                        _showDeleteConfirmation(
                          context,
                          'Hapus Penjualan',
                          'Apakah Anda yakin ingin menghapus data penjualan ini?',
                          () => _deleteSale(sale.id),
                        );
                        break;
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(Icons.edit, size: 20),
                          SizedBox(width: 8),
                          Text('Edit'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete, color: Colors.red, size: 20),
                          SizedBox(width: 8),
                          Text('Hapus', style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Jumlah', style: TextStyle(fontSize: 12, color: Colors.grey)),
                      Text(
                        '${sale.quantity} items',
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Total', style: TextStyle(fontSize: 12, color: Colors.grey)),
                      Text(
                        'Rp ${sale.totalPrice.toStringAsFixed(0)}',
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF2E8B57)),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Pembayaran', style: TextStyle(fontSize: 12, color: Colors.grey)),
                      Text(
                        sale.paymentMethod,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Tanggal: ${_formatDateTime(sale.saleDate)}',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(String title, String subtitle) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Form Methods
  void _showProductForm(BuildContext context, {Product? product}) {
    final nameController = TextEditingController(text: product?.name ?? '');
    final categoryController = TextEditingController(text: product?.category ?? '');
    final priceController = TextEditingController(text: product?.price.toString() ?? '');
    final stockController = TextEditingController(text: product?.stock.toString() ?? '');
    final unitController = TextEditingController(text: product?.unit ?? '');
    final descriptionController = TextEditingController(text: product?.description ?? '');

    String selectedCategory = product?.category ?? 'Minuman Panas';
    final categories = ['Minuman Panas', 'Minuman Dingin', 'Makanan', 'Snack'];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              product == null ? Icons.add_box : Icons.edit,
              color: const Color(0xFF2E8B57),
            ),
            const SizedBox(width: 8),
            Text(product == null ? 'Tambah Produk' : 'Edit Produk'),
          ],
        ),
        content: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nama Produk',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.fastfood),
                  ),
                ),
                const SizedBox(height: 16),
                StatefulBuilder(
                  builder: (context, setState) {
                    return DropdownButtonFormField<String>(
                      value: selectedCategory,
                      decoration: const InputDecoration(
                        labelText: 'Kategori',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.category),
                      ),
                      items: categories.map((category) {
                        return DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedCategory = value!;
                          categoryController.text = value;
                        });
                      },
                    );
                  },
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Harga',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.attach_money),
                    prefixText: 'Rp ',
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: stockController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Stok',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.inventory),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextField(
                        controller: unitController,
                        decoration: const InputDecoration(
                          labelText: 'Satuan',
                          border: OutlineInputBorder(),
                          hintText: 'gelas, porsi, pcs',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: descriptionController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Deskripsi',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.description),
                    hintText: 'Deskripsi produk...',
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_validateProductForm(nameController, categoryController, priceController, stockController, unitController, descriptionController)) {
                final newProduct = Product(
                  id: product?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
                  name: nameController.text,
                  category: selectedCategory,
                  price: double.parse(priceController.text),
                  stock: int.parse(stockController.text),
                  unit: unitController.text,
                  description: descriptionController.text,
                  createdAt: product?.createdAt ?? DateTime.now(),
                );

                if (product == null) {
                  _addProduct(newProduct);
                } else {
                  _updateProduct(newProduct);
                }
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2E8B57)),
            child: Text(
              product == null ? 'Tambah' : 'Update',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _showRawMaterialForm(BuildContext context, {RawMaterial? material}) {
    final nameController = TextEditingController(text: material?.name ?? '');
    final supplierController = TextEditingController(text: material?.supplier ?? '');
    final stockController = TextEditingController(text: material?.stock.toString() ?? '');
    final unitController = TextEditingController(text: material?.unit ?? '');
    final minStockController = TextEditingController(text: material?.minStock.toString() ?? '');
    final priceController = TextEditingController(text: material?.price.toString() ?? '');
    DateTime selectedExpiryDate = material?.expiryDate ?? DateTime.now().add(const Duration(days: 365));

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Row(
              children: [
                Icon(
                  material == null ? Icons.add_box : Icons.edit,
                  color: const Color(0xFF4682B4),
                ),
                const SizedBox(width: 8),
                Text(material == null ? 'Tambah Bahan Baku' : 'Edit Bahan Baku'),
              ],
            ),
            content: SingleChildScrollView(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Nama Bahan Baku',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.inventory),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: supplierController,
                      decoration: const InputDecoration(
                        labelText: 'Supplier',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.business),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: stockController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Stok',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.numbers),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextField(
                            controller: unitController,
                            decoration: const InputDecoration(
                              labelText: 'Satuan',
                              border: OutlineInputBorder(),
                              hintText: 'kg, liter, pcs',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: minStockController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Minimum Stok',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.warning),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextField(
                            controller: priceController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Harga',
                              border: OutlineInputBorder(),
                              prefixText: 'Rp ',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    InkWell(
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: selectedExpiryDate,
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(const Duration(days: 1825)),
                        );
                        if (date != null) {
                          setState(() {
                            selectedExpiryDate = date;
                          });
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.calendar_today, color: Colors.grey),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Tanggal Kadaluarsa',
                                  style: TextStyle(fontSize: 12, color: Colors.grey),
                                ),
                                Text(
                                  _formatDate(selectedExpiryDate),
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Batal'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_validateRawMaterialForm(nameController, supplierController, stockController, unitController, minStockController, priceController)) {
                    final newMaterial = RawMaterial(
                      id: material?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
                      name: nameController.text,
                      supplier: supplierController.text,
                      stock: int.parse(stockController.text),
                      unit: unitController.text,
                      minStock: int.parse(minStockController.text),
                      price: double.parse(priceController.text),
                      lastRestocked: material?.lastRestocked ?? DateTime.now(),
                      expiryDate: selectedExpiryDate,
                    );

                    if (material == null) {
                      _addRawMaterial(newMaterial);
                    } else {
                      _updateRawMaterial(newMaterial);
                    }
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4682B4)),
                child: Text(
                  material == null ? 'Tambah' : 'Update',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showSaleForm(BuildContext context, {Sale? sale}) {
    String? selectedProductId = sale?.productId;
    final quantityController = TextEditingController(text: sale?.quantity.toString() ?? '');
    final customerNameController = TextEditingController(text: sale?.customerName ?? '');
    String selectedPaymentMethod = sale?.paymentMethod ?? 'Tunai';
    final paymentMethods = ['Tunai', 'Transfer', 'Kartu Kredit', 'E-Wallet'];

    double unitPrice = 0;
    double totalPrice = 0;

    if (sale != null) {
      unitPrice = sale.unitPrice;
      totalPrice = sale.totalPrice;
    }

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          void updateTotal() {
            if (selectedProductId != null && quantityController.text.isNotEmpty) {
              final product = products.firstWhere((p) => p.id == selectedProductId);
              unitPrice = product.price;
              final quantity = double.tryParse(quantityController.text) ?? 0;
              totalPrice = unitPrice * quantity;
            }
          }

          return AlertDialog(
            title: Row(
              children: [
                Icon(
                  sale == null ? Icons.add_shopping_cart : Icons.edit,
                  color: const Color(0xFFFF8C00),
                ),
                const SizedBox(width: 8),
                Text(sale == null ? 'Catat Penjualan' : 'Edit Penjualan'),
              ],
            ),
            content: SingleChildScrollView(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButtonFormField<String>(
                      value: selectedProductId,
                      decoration: const InputDecoration(
                        labelText: 'Produk',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.fastfood),
                      ),
                      items: products.map((product) {
                        return DropdownMenuItem(
                          value: product.id,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(product.name),
                              Text(
                                'Stok: ${product.stock} ${product.unit} - Rp ${product.price.toStringAsFixed(0)}',
                                style: const TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedProductId = value;
                          updateTotal();
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: quantityController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Jumlah',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.numbers),
                      ),
                      onChanged: (value) {
                        setState(() {
                          updateTotal();
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: customerNameController,
                      decoration: const InputDecoration(
                        labelText: 'Nama Pelanggan',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: selectedPaymentMethod,
                      decoration: const InputDecoration(
                        labelText: 'Metode Pembayaran',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.payment),
                      ),
                      items: paymentMethods.map((method) {
                        return DropdownMenuItem(
                          value: method,
                          child: Text(method),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedPaymentMethod = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2E8B57).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFF2E8B57).withOpacity(0.3)),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Harga Satuan:'),
                              Text(
                                'Rp ${unitPrice.toStringAsFixed(0)}',
                                style: const TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Total:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              Text(
                                'Rp ${totalPrice.toStringAsFixed(0)}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2E8B57),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Batal'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_validateSaleForm(selectedProductId, quantityController, customerNameController)) {
                    final newSale = Sale(
                      id: sale?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
                      productId: selectedProductId!,
                      productName: products.firstWhere((p) => p.id == selectedProductId).name,
                      quantity: int.parse(quantityController.text),
                      unitPrice: unitPrice,
                      totalPrice: totalPrice,
                      saleDate: sale?.saleDate ?? DateTime.now(),
                      customerName: customerNameController.text,
                      paymentMethod: selectedPaymentMethod,
                    );

                    if (sale == null) {
                      _addSale(newSale);
                    } else {
                      _updateSale(newSale);
                    }
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF8C00)),
                child: Text(
                  sale == null ? 'Catat' : 'Update',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // Validation Methods
  bool _validateProductForm(
    TextEditingController name,
    TextEditingController category,
    TextEditingController price,
    TextEditingController stock,
    TextEditingController unit,
    TextEditingController description,
  ) {
    if (name.text.trim().isEmpty) {
      _showErrorSnackBar('Nama produk harus diisi');
      return false;
    }
    if (price.text.isEmpty || double.tryParse(price.text) == null || double.parse(price.text) <= 0) {
      _showErrorSnackBar('Harga harus berupa angka valid dan lebih dari 0');
      return false;
    }
    if (stock.text.isEmpty || int.tryParse(stock.text) == null || int.parse(stock.text) < 0) {
      _showErrorSnackBar('Stok harus berupa angka valid dan tidak boleh negatif');
      return false;
    }
    if (unit.text.trim().isEmpty) {
      _showErrorSnackBar('Satuan harus diisi');
      return false;
    }
    if (description.text.trim().isEmpty) {
      _showErrorSnackBar('Deskripsi harus diisi');
      return false;
    }
    return true;
  }

  bool _validateRawMaterialForm(
    TextEditingController name,
    TextEditingController supplier,
    TextEditingController stock,
    TextEditingController unit,
    TextEditingController minStock,
    TextEditingController price,
  ) {
    if (name.text.trim().isEmpty) {
      _showErrorSnackBar('Nama bahan baku harus diisi');
      return false;
    }
    if (supplier.text.trim().isEmpty) {
      _showErrorSnackBar('Supplier harus diisi');
      return false;
    }
    if (stock.text.isEmpty || int.tryParse(stock.text) == null || int.parse(stock.text) < 0) {
      _showErrorSnackBar('Stok harus berupa angka valid dan tidak boleh negatif');
      return false;
    }
    if (unit.text.trim().isEmpty) {
      _showErrorSnackBar('Satuan harus diisi');
      return false;
    }
    if (minStock.text.isEmpty || int.tryParse(minStock.text) == null || int.parse(minStock.text) < 0) {
      _showErrorSnackBar('Minimum stok harus berupa angka valid dan tidak boleh negatif');
      return false;
    }
    if (price.text.isEmpty || double.tryParse(price.text) == null || double.parse(price.text) <= 0) {
      _showErrorSnackBar('Harga harus berupa angka valid dan lebih dari 0');
      return false;
    }
    return true;
  }

  bool _validateSaleForm(
    String? productId,
    TextEditingController quantity,
    TextEditingController customerName,
  ) {
    if (productId == null) {
      _showErrorSnackBar('Produk harus dipilih');
      return false;
    }
    if (quantity.text.isEmpty || int.tryParse(quantity.text) == null || int.parse(quantity.text) <= 0) {
      _showErrorSnackBar('Jumlah harus berupa angka valid dan lebih dari 0');
      return false;
    }
    if (customerName.text.trim().isEmpty) {
      _showErrorSnackBar('Nama pelanggan harus diisi');
      return false;
    }

    // Check if product has enough stock
    final product = products.firstWhere((p) => p.id == productId);
    final requestedQty = int.parse(quantity.text);
    if (product.stock < requestedQty) {
      _showErrorSnackBar('Stok tidak mencukupi! Tersedia: ${product.stock} ${product.unit}');
      return false;
    }

    return true;
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: const Color(0xFF2E8B57),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 4),
      ),
    );
  }

  // Modal and Dialog Methods
  void _showNotifications(BuildContext context) {
    final lowStockProductsList = products.where((p) => p.stock <= 10).toList();
    final lowStockMaterialsList = rawMaterials.where((m) => m.stock <= m.minStock).toList();
    final expiringSoonMaterials = rawMaterials.where((m) => 
        m.expiryDate.difference(DateTime.now()).inDays <= 30).toList();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Icon(Icons.notifications, color: Color(0xFFFF6B35), size: 28),
                  SizedBox(width: 12),
                  Text(
                    'Notifikasi',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  // Low stock products
                  if (lowStockProductsList.isNotEmpty) ...[
                    const Text(
                      'Produk Stok Rendah',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
                    ),
                    const SizedBox(height: 8),
                    ...lowStockProductsList.map((product) => ListTile(
                      leading: const Icon(Icons.warning_amber, color: Colors.red),
                      title: Text(product.name),
                      subtitle: Text('Stok: ${product.stock} ${product.unit}'),
                      trailing: const Text('Rendah', style: TextStyle(color: Colors.red)),
                    )),
                    const SizedBox(height: 16),
                  ],
                  
                  // Low stock materials
                  if (lowStockMaterialsList.isNotEmpty) ...[
                    const Text(
                      'Bahan Baku Perlu Restok',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.orange),
                    ),
                    const SizedBox(height: 8),
                    ...lowStockMaterialsList.map((material) => ListTile(
                      leading: const Icon(Icons.priority_high, color: Colors.orange),
                      title: Text(material.name),
                      subtitle: Text('Stok: ${material.stock}/${material.minStock} ${material.unit}'),
                      trailing: const Text('Restok', style: TextStyle(color: Colors.orange)),
                    )),
                    const SizedBox(height: 16),
                  ],
                  
                  // Expiring materials
                  if (expiringSoonMaterials.isNotEmpty) ...[
                    const Text(
                      'Segera Kadaluarsa',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                    const SizedBox(height: 8),
                    ...expiringSoonMaterials.map((material) => ListTile(
                      leading: const Icon(Icons.schedule, color: Colors.blue),
                      title: Text(material.name),
                      subtitle: Text('Kadaluarsa: ${_formatDate(material.expiryDate)}'),
                      trailing: Text(
                        '${material.expiryDate.difference(DateTime.now()).inDays} hari',
                        style: const TextStyle(color: Colors.blue),
                      ),
                    )),
                  ],
                  
                  // General notifications
                  const ListTile(
                    leading: Icon(Icons.celebration, color: Colors.green),
                    title: Text('Target Penjualan Tercapai'),
                    subtitle: Text('Penjualan hari ini mencapai target yang ditetapkan'),
                    trailing: Text('Hari ini'),
                  ),
                  const ListTile(
                    leading: Icon(Icons.backup, color: Colors.blue),
                    title: Text('Backup Otomatis Berhasil'),
                    subtitle: Text('Data berhasil di-backup secara otomatis'),
                    trailing: Text('1 jam lalu'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showProfileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            const CircleAvatar(
              radius: 40,
              backgroundColor: Color(0xFF8B4513),
              child: Icon(Icons.person, color: Colors.white, size: 40),
            ),
            const SizedBox(height: 16),
            const Text(
              'Admin Warkop',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text(
              'admin@warkop.com',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.person_outline),
              title: const Text('Profil Saya'),
              onTap: () {
                Navigator.pop(context);
                _showComingSoonDialog(context, 'Profil');
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings_outlined),
              title: const Text('Pengaturan'),
              onTap: () {
                Navigator.pop(context);
                _showComingSoonDialog(context, 'Pengaturan');
              },
            ),
            ListTile(
              leading: const Icon(Icons.help_outline),
              title: const Text('Bantuan'),
              onTap: () {
                Navigator.pop(context);
                _showHelpDialog(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('Tentang Aplikasi'),
              onTap: () {
                Navigator.pop(context);
                _showAboutDialog(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Keluar', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
                _showLogoutConfirmation(context);
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showQuickActionsModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Quick Actions',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  _buildQuickModalAction('Tambah\nProduk', Icons.add_box, const Color(0xFF2E8B57), () {
                    Navigator.pop(context);
                    _showProductForm(context);
                  }),
                  _buildQuickModalAction('Catat\nPenjualan', Icons.point_of_sale, const Color(0xFF4682B4), () {
                    Navigator.pop(context);
                    _showSaleForm(context);
                  }),
                  _buildQuickModalAction('Tambah\nBahan Baku', Icons.inventory, const Color(0xFFFF8C00), () {
                    Navigator.pop(context);
                    _showRawMaterialForm(context);
                  }),
                  _buildQuickModalAction('Lihat\nStok Produk', Icons.restaurant_menu, const Color(0xFF9370DB), () {
                    Navigator.pop(context);
                    _navigateToProductStock(context);
                  }),
                  _buildQuickModalAction('Lihat\nBahan Baku', Icons.inventory_2, const Color(0xFFDC143C), () {
                    Navigator.pop(context);
                    _navigateToRawMaterials(context);
                  }),
                  _buildQuickModalAction('Lihat\nPenjualan', Icons.receipt_long, const Color(0xFF708090), () {
                    Navigator.pop(context);
                    _navigateToSalesRecord(context);
                  }),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickModalAction(String title, IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAllActivity(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Semua Aktivitas'),
        content: SizedBox(
          width: double.maxFinite,
          height: 400,
          child: ListView.builder(
            itemCount: 15,
            itemBuilder: (context, index) {
              final activities = [
                {'title': 'Produk baru ditambahkan', 'icon': Icons.add_circle, 'color': const Color(0xFF2E8B57)},
                {'title': 'Penjualan berhasil dicatat', 'icon': Icons.shopping_cart, 'color': const Color(0xFF4682B4)},
                {'title': 'Stok bahan baku diperbarui', 'icon': Icons.inventory, 'color': const Color(0xFFFF8C00)},
                {'title': 'Laporan harian dibuat', 'icon': Icons.description, 'color': const Color(0xFF9370DB)},
                {'title': 'Backup data berhasil', 'icon': Icons.backup, 'color': const Color(0xFF8B4513)},
              ];
              
              final activity = activities[index % activities.length];
              
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: (activity['color'] as Color).withOpacity(0.1),
                  child: Icon(activity['icon'] as IconData, color: activity['color'] as Color),
                ),
                title: Text(activity['title'] as String),
                subtitle: Text('${index + 1} ${index == 0 ? 'menit' : index < 60 ? 'menit' : 'jam'} yang lalu'),
                trailing: Icon(Icons.chevron_right, color: Colors.grey[400]),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  void _showReportsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.analytics, color: Color(0xFF9370DB)),
            SizedBox(width: 8),
            Text('Laporan & Analisis'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.trending_up, color: Color(0xFF2E8B57)),
              title: const Text('Laporan Penjualan'),
              subtitle: Text('Total hari ini: ${_formatCurrency(todaySales)}'),
              onTap: () {
                Navigator.pop(context);
                _showSalesReportDialog(context); // Gunakan method yang baru
              },
            ),
            ListTile(
              leading: const Icon(Icons.inventory_2, color: Color(0xFF4682B4)),
              title: const Text('Laporan Stok'),
              subtitle: Text('$totalProducts produk, $lowStockProducts stok rendah'),
              onTap: () {
                Navigator.pop(context);
                _showStockReport();
              },
            ),
            ListTile(
              leading: const Icon(Icons.attach_money, color: Color(0xFFFF8C00)),
              title: const Text('Laporan Keuangan'),
              subtitle: const Text('Pendapatan dan pengeluaran'),
              onTap: () {
                Navigator.pop(context);
                _showFinancialReport();
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  void _showSalesReport() {
    _showSuccessSnackBar('Laporan penjualan sedang disiapkan...');
  }

  void _showStockReport() {
    _showSuccessSnackBar('Laporan stok sedang disiapkan...');
  }

  void _showFinancialReport() {
    _showSuccessSnackBar('Laporan keuangan sedang disiapkan...');
  }

  void _showBackupDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.backup, color: Color(0xFF8B4513)),
            SizedBox(width: 8),
            Text('Backup Data'),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Pilih jenis backup yang ingin dilakukan:'),
            SizedBox(height: 16),
            ListTile(
              leading: Icon(Icons.cloud_upload, color: Color(0xFF4682B4)),
              title: Text('Backup ke Cloud'),
              subtitle: Text('Simpan data ke cloud storage'),
            ),
            ListTile(
              leading: Icon(Icons.save_alt, color: Color(0xFF2E8B57)),
              title: Text('Export ke File'),
              subtitle: Text('Download data dalam format Excel'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _performBackup();
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF8B4513)),
            child: const Text('Mulai Backup', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _performBackup() {
    _showSuccessSnackBar('Backup data berhasil dilakukan!');
  }

  void _showComingSoonDialog(BuildContext context, String feature) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.construction, color: Color(0xFFFF8C00)),
            const SizedBox(width: 8),
            Text('$feature - Coming Soon'),
          ],
        ),
        content: Text('Fitur $feature sedang dalam pengembangan dan akan segera tersedia dalam update mendatang.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.help, color: Color(0xFF4682B4)),
            SizedBox(width: 8),
            Text('Bantuan'),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Panduan Penggunaan:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('• Gunakan menu utama untuk mengakses fitur'),
            Text('• Tekan tombol + untuk menambah data baru'),
            Text('• Tekan menu ⋮ pada card untuk edit/hapus'),
            Text('• Cek notifikasi untuk peringatan stok'),
            SizedBox(height: 16),
            Text('Kontak Support:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Email: support@warkop.com'),
            Text('Telepon: 0812-3456-7890'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.info, color: Color(0xFF8B4513)),
            SizedBox(width: 8),
            Text('Tentang Aplikasi'),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Warkop Manager', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Versi 1.0.0'),
            SizedBox(height: 16),
            Text('Aplikasi manajemen warkop terpadu untuk membantu mengelola:'),
            SizedBox(height: 8),
            Text('• Stok produk dan bahan baku'),
            Text('• Pencatatan penjualan'),
            Text('• Laporan dan analisis'),
            Text('• Notifikasi stok rendah'),
            SizedBox(height: 16),
            Text('Dikembangkan dengan Flutter', style: TextStyle(fontStyle: FontStyle.italic)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.logout, color: Colors.red),
            SizedBox(width: 8),
            Text('Konfirmasi Keluar'),
          ],
        ),
        content: const Text('Apakah Anda yakin ingin keluar dari aplikasi?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showSuccessSnackBar('Berhasil keluar dari aplikasi');
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Keluar', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'minuman panas':
        return Icons.local_cafe;
      case 'minuman dingin':
        return Icons.local_drink;
      case 'makanan':
        return Icons.restaurant;
      default:
        return Icons.fastfood;
    }
  }

  // Method untuk menghitung laporan penjualan berdasarkan periode
  Map<String, dynamic> _calculateSalesReport(String period, DateTime selectedDate) {
    List<Sale> filteredSales = [];
    
    switch (period) {
      case 'daily':
        filteredSales = sales.where((sale) => _isSameDay(sale.saleDate, selectedDate)).toList();
        break;
      case 'monthly':
        filteredSales = sales.where((sale) => 
          sale.saleDate.year == selectedDate.year && 
          sale.saleDate.month == selectedDate.month
        ).toList();
        break;
      case 'yearly':
        filteredSales = sales.where((sale) => 
          sale.saleDate.year == selectedDate.year
        ).toList();
        break;
    }

    double totalRevenue = filteredSales.fold(0.0, (sum, sale) => sum + sale.totalPrice);
    int totalOrders = filteredSales.length;
    int totalItems = filteredSales.fold(0, (sum, sale) => sum + sale.quantity);
    
    // Hitung produk terlaris
    Map<String, int> productSales = {};
    Map<String, double> productRevenue = {};
    
    for (var sale in filteredSales) {
      productSales[sale.productName] = (productSales[sale.productName] ?? 0) + sale.quantity;
      productRevenue[sale.productName] = (productRevenue[sale.productName] ?? 0) + sale.totalPrice;
    }
    
    // Urutkan produk berdasarkan jumlah terjual
    var sortedProducts = productSales.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    
    // Hitung penjualan per metode pembayaran
    Map<String, int> paymentMethods = {};
    for (var sale in filteredSales) {
      paymentMethods[sale.paymentMethod] = (paymentMethods[sale.paymentMethod] ?? 0) + 1;
    }

    return {
      'sales': filteredSales,
      'totalRevenue': totalRevenue,
      'totalOrders': totalOrders,
      'totalItems': totalItems,
      'topProducts': sortedProducts,
      'productRevenue': productRevenue,
      'paymentMethods': paymentMethods,
    };
  }

  // Method untuk menampilkan laporan penjualan
  void _showSalesReportDialog(BuildContext context) {
    String selectedPeriod = 'daily';
    DateTime selectedDate = DateTime.now();
    
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          final reportData = _calculateSalesReport(selectedPeriod, selectedDate);
          
          return AlertDialog(
            title: const Row(
              children: [
                Icon(Icons.trending_up, color: Color(0xFF2E8B57)),
                SizedBox(width: 8),
                Text('Laporan Penjualan'),
              ],
            ),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Filter Periode
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: selectedPeriod,
                          decoration: const InputDecoration(
                            labelText: 'Periode',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.calendar_view_day),
                          ),
                          items: const [
                            DropdownMenuItem(value: 'daily', child: Text('Harian')),
                            DropdownMenuItem(value: 'monthly', child: Text('Bulanan')),
                            DropdownMenuItem(value: 'yearly', child: Text('Tahunan')),
                          ],
                          onChanged: (value) {
                            setState(() {
                              selectedPeriod = value!;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            final date = await showDatePicker(
                              context: context,
                              initialDate: selectedDate,
                              firstDate: DateTime(2020),
                              lastDate: DateTime.now(),
                            );
                            if (date != null) {
                              setState(() {
                                selectedDate = date;
                              });
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.calendar_today, color: Colors.grey),
                                const SizedBox(width: 8),
                                Text(_getPeriodText(selectedPeriod, selectedDate)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Ringkasan
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2E8B57).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFF2E8B57).withOpacity(0.3)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Total Pendapatan', style: TextStyle(fontSize: 12, color: Colors.grey)),
                                Text(
                                  _formatCurrency(reportData['totalRevenue']),
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF2E8B57)),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Total Pesanan', style: TextStyle(fontSize: 12, color: Colors.grey)),
                                Text(
                                  '${reportData['totalOrders']} pesanan',
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Total Item', style: TextStyle(fontSize: 12, color: Colors.grey)),
                                Text(
                                  '${reportData['totalItems']} item',
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Rata-rata per Pesanan', style: TextStyle(fontSize: 12, color: Colors.grey)),
                                Text(
                                  reportData['totalOrders'] > 0 
                                    ? _formatCurrency(reportData['totalRevenue'] / reportData['totalOrders'])
                                    : 'Rp 0',
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Detail laporan dalam tabs
                  Expanded(
                    child: DefaultTabController(
                      length: 3,
                      child: Column(
                        children: [
                          const TabBar(
                            labelColor: Color(0xFF2E8B57),
                            unselectedLabelColor: Colors.grey,
                            tabs: [
                              Tab(text: 'Produk Terlaris'),
                              Tab(text: 'Detail Transaksi'),
                              Tab(text: 'Metode Pembayaran'),
                            ],
                          ),
                          Expanded(
                            child: TabBarView(
                              children: [
                                // Tab Produk Terlaris
                                _buildTopProductsTab(reportData),
                                // Tab Detail Transaksi
                                _buildTransactionDetailsTab(reportData['sales']),
                                // Tab Metode Pembayaran
                                _buildPaymentMethodsTab(reportData['paymentMethods']),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Tutup'),
              ),
              ElevatedButton(
                onPressed: () => _exportSalesReport(reportData, selectedPeriod, selectedDate),
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2E8B57)),
                child: const Text('Export', style: TextStyle(color: Colors.white)),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTopProductsTab(Map<String, dynamic> reportData) {
    final topProducts = reportData['topProducts'] as List<MapEntry<String, int>>;
    final productRevenue = reportData['productRevenue'] as Map<String, double>;
    
    if (topProducts.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_cart_outlined, size: 60, color: Colors.grey),
            SizedBox(height: 16),
            Text('Tidak ada data penjualan'),
          ],
        ),
      );
    }
    
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: topProducts.length,
      itemBuilder: (context, index) {
        final product = topProducts[index];
        final revenue = productRevenue[product.key] ?? 0;
        
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: const Color(0xFF2E8B57).withOpacity(0.1),
              child: Text(
                '${index + 1}',
                style: const TextStyle(color: Color(0xFF2E8B57), fontWeight: FontWeight.bold),
              ),
            ),
            title: Text(product.key),
            subtitle: Text('${product.value} item terjual'),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _formatCurrency(revenue),
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2E8B57)),
                ),
                Text(
                  '${((revenue / reportData['totalRevenue']) * 100).toStringAsFixed(1)}%',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTransactionDetailsTab(List<Sale> sales) {
    if (sales.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.receipt_outlined, size: 60, color: Colors.grey),
            SizedBox(height: 16),
            Text('Tidak ada transaksi'),
          ],
        ),
      );
    }
    
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: sales.length,
      itemBuilder: (context, index) {
        final sale = sales[sales.length - 1 - index]; // Tampilkan terbaru dulu
        
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFFF8C00).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.shopping_cart, color: Color(0xFFFF8C00), size: 20),
            ),
            title: Text(sale.productName),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Pelanggan: ${sale.customerName}'),
                Text('${_formatDateTime(sale.saleDate)} • ${sale.paymentMethod}'),
              ],
            ),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _formatCurrency(sale.totalPrice),
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2E8B57)),
                ),
                Text(
                  '${sale.quantity} item',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPaymentMethodsTab(Map<String, int> paymentMethods) {
    if (paymentMethods.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.payment_outlined, size: 60, color: Colors.grey),
            SizedBox(height: 16),
            Text('Tidak ada data pembayaran'),
          ],
        ),
      );
    }
    
    final total = paymentMethods.values.fold(0, (sum, count) => sum + count);
    final sortedMethods = paymentMethods.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: sortedMethods.length,
      itemBuilder: (context, index) {
        final method = sortedMethods[index];
        final percentage = (method.value / total * 100);
        
        Color methodColor;
        IconData methodIcon;
        
        switch (method.key.toLowerCase()) {
          case 'tunai':
            methodColor = const Color(0xFF4CAF50);
            methodIcon = Icons.money;
            break;
          case 'transfer':
            methodColor = const Color(0xFF2196F3);
            methodIcon = Icons.account_balance;
            break;
          case 'kartu kredit':
            methodColor = const Color(0xFFFF9800);
            methodIcon = Icons.credit_card;
            break;
          case 'e-wallet':
            methodColor = const Color(0xFF9C27B0);
            methodIcon = Icons.phone_android;
            break;
          default:
            methodColor = Colors.grey;
            methodIcon = Icons.payment;
        }
        
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: methodColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(methodIcon, color: methodColor, size: 20),
            ),
            title: Text(method.key),
            subtitle: LinearProgressIndicator(
              value: percentage / 100,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(methodColor),
            ),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${method.value} transaksi',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '${percentage.toStringAsFixed(1)}%',
                  style: TextStyle(fontSize: 12, color: methodColor),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _getPeriodText(String period, DateTime date) {
    switch (period) {
      case 'daily':
        return _formatDate(date);
      case 'monthly':
        return '${_getMonthName(date.month)} ${date.year}';
      case 'yearly':
        return '${date.year}';
      default:
        return _formatDate(date);
    }
  }

  String _getMonthName(int month) {
    const months = ['Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
                   'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'];
    return months[month - 1];
  }

  void _exportSalesReport(Map<String, dynamic> reportData, String period, DateTime date) {
    // Simulasi export - dalam implementasi nyata bisa export ke PDF/Excel
    _showSuccessSnackBar('Laporan berhasil diekspor!');
  }

  // Tambahkan method ini ke dalam class _MainPageState

// Method untuk menampilkan laporan stok lengkap
void _showStockReportDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Row(
        children: [
          Icon(Icons.inventory_2, color: Color(0xFF4682B4)),
          SizedBox(width: 8),
          Text('Laporan Stok'),
        ],
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.95,
        height: MediaQuery.of(context).size.height * 0.8,
        child: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              // Summary Cards
              _buildStockSummaryCards(),
              
              const SizedBox(height: 16),
              
              // Tab Bar
              const TabBar(
                labelColor: Color(0xFF4682B4),
                unselectedLabelColor: Colors.grey,
                indicatorColor: Color(0xFF4682B4),
                tabs: [
                  Tab(
                    icon: Icon(Icons.restaurant_menu),
                    text: 'Produk',
                  ),
                  Tab(
                    icon: Icon(Icons.inventory),
                    text: 'Bahan Baku',
                  ),
                  Tab(
                    icon: Icon(Icons.analytics),
                    text: 'Analisis',
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              // Tab Views
              Expanded(
                child: TabBarView(
                  children: [
                    _buildProductStockTab(),
                    _buildRawMaterialStockTab(),
                    _buildStockAnalysisTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Tutup'),
        ),
        ElevatedButton(
          onPressed: () => _exportStockReport(),
          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4682B4)),
          child: const Text('Export', style: TextStyle(color: Colors.white)),
        ),
      ],
    ),
  );
}

// Widget untuk summary cards
Widget _buildStockSummaryCards() {
  final lowStockProducts = products.where((p) => p.stock <= 10).length;
  final lowStockMaterials = rawMaterials.where((m) => m.stock <= m.minStock).length;
  final expiringSoon = rawMaterials.where((m) => 
    m.expiryDate.difference(DateTime.now()).inDays <= 30).length;
  
  final totalProductValue = products.fold(0.0, (sum, p) => sum + (p.price * p.stock));
  final totalMaterialValue = rawMaterials.fold(0.0, (sum, m) => sum + (m.price * m.stock));
  
  return Column(
    children: [
      Row(
        children: [
          Expanded(
            child: _buildSummaryCard(
              'Total Produk',
              products.length.toString(),
              Icons.restaurant_menu,
              const Color(0xFF2E8B57),
              'items',
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _buildSummaryCard(
              'Stok Rendah',
              lowStockProducts.toString(),
              Icons.warning_amber,
              Colors.orange,
              'items',
            ),
          ),
        ],
      ),
      const SizedBox(height: 8),
      Row(
        children: [
          Expanded(
            child: _buildSummaryCard(
              'Total Bahan',
              rawMaterials.length.toString(),
              Icons.inventory,
              const Color(0xFF4682B4),
              'items',
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _buildSummaryCard(
              'Perlu Restok',
              lowStockMaterials.toString(),
              Icons.priority_high,
              Colors.red,
              'items',
            ),
          ),
        ],
      ),
      const SizedBox(height: 8),
      Row(
        children: [
          Expanded(
            child: _buildSummaryCard(
              'Nilai Produk',
              _formatCurrency(totalProductValue),
              Icons.attach_money,
              const Color(0xFF9C27B0),
              '',
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _buildSummaryCard(
              'Segera Expired',
              expiringSoon.toString(),
              Icons.schedule,
              Colors.orange,
              'items',
            ),
          ),
        ],
      ),
    ],
  );
}

// Widget untuk summary card yang lebih kecil
Widget _buildSummaryCard(String title, String value, IconData icon, Color color, String suffix) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withOpacity(0.3)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 16),
            const Spacer(),
            Icon(Icons.trending_up, color: color.withOpacity(0.6), size: 12),
          ],
        ),
        const SizedBox(height: 6),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          title,
          style: const TextStyle(
            fontSize: 10,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );
}

// Tab untuk laporan stok produk
Widget _buildProductStockTab() {
  if (products.isEmpty) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inventory_outlined, size: 60, color: Colors.grey),
          SizedBox(height: 16),
          Text('Tidak ada data produk'),
        ],
      ),
    );
  }

  // Urutkan produk berdasarkan kategori dan stok
  final sortedProducts = List<Product>.from(products);
  sortedProducts.sort((a, b) {
    // Prioritas: stok rendah dulu, lalu berdasarkan kategori
    if (a.stock <= 10 && b.stock > 10) return -1;
    if (a.stock > 10 && b.stock <= 10) return 1;
    return a.category.compareTo(b.category);
  });

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Filter dan statistik
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF2E8B57).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Status Stok Produk', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text('${products.where((p) => p.stock > 10).length} Normal • ${products.where((p) => p.stock <= 10).length} Rendah'),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: products.where((p) => p.stock <= 10).isNotEmpty 
                  ? Colors.orange 
                  : const Color(0xFF2E8B57),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                products.where((p) => p.stock <= 10).isNotEmpty 
                  ? 'Perlu Perhatian' 
                  : 'Stok Aman',
                style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      
      const SizedBox(height: 12),
      
      // Daftar produk
      Expanded(
        child: ListView.builder(
          itemCount: sortedProducts.length,
          itemBuilder: (context, index) {
            final product = sortedProducts[index];
            final isLowStock = product.stock <= 10;
            final stockValue = product.price * product.stock;
            
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              elevation: isLowStock ? 3 : 1,
              color: isLowStock ? Colors.orange.withOpacity(0.05) : null,
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isLowStock 
                      ? Colors.orange.withOpacity(0.2)
                      : const Color(0xFF2E8B57).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    _getCategoryIcon(product.category),
                    color: isLowStock ? Colors.orange : const Color(0xFF2E8B57),
                    size: 20,
                  ),
                ),
                title: Row(
                  children: [
                    Expanded(child: Text(product.name, style: const TextStyle(fontWeight: FontWeight.w600))),
                    if (isLowStock) 
                      const Icon(Icons.warning, color: Colors.orange, size: 16),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.category),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Text('Stok: ', style: TextStyle(color: Colors.grey[600])),
                        Text(
                          '${product.stock} ${product.unit}',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: isLowStock ? Colors.orange : Colors.black,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text('Nilai: ${_formatCurrency(stockValue)}'),
                      ],
                    ),
                  ],
                ),
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '@ ${_formatCurrency(product.price)}',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(height: 2),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: isLowStock ? Colors.orange : const Color(0xFF2E8B57),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        isLowStock ? 'RENDAH' : 'NORMAL',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    ],
  );
}

// Tab untuk laporan stok bahan baku
Widget _buildRawMaterialStockTab() {
  if (rawMaterials.isEmpty) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inventory_2_outlined, size: 60, color: Colors.grey),
          SizedBox(height: 16),
          Text('Tidak ada data bahan baku'),
        ],
      ),
    );
  }

  // Urutkan bahan baku berdasarkan prioritas (stok rendah dan expiry)
  final sortedMaterials = List<RawMaterial>.from(rawMaterials);
  sortedMaterials.sort((a, b) {
    final aLowStock = a.stock <= a.minStock;
    final bLowStock = b.stock <= b.minStock;
    final aExpiringSoon = a.expiryDate.difference(DateTime.now()).inDays <= 30;
    final bExpiringSoon = b.expiryDate.difference(DateTime.now()).inDays <= 30;
    
    // Prioritas: stok rendah atau expiring soon dulu
    if ((aLowStock || aExpiringSoon) && !(bLowStock || bExpiringSoon)) return -1;
    if (!(aLowStock || aExpiringSoon) && (bLowStock || bExpiringSoon)) return 1;
    return a.name.compareTo(b.name);
  });

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Status summary
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF4682B4).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Status Bahan Baku', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _buildMaterialStatusIndicator(
                    'Normal',
                    rawMaterials.where((m) => m.stock > m.minStock && 
                      m.expiryDate.difference(DateTime.now()).inDays > 30).length,
                    const Color(0xFF2E8B57),
                  ),
                ),
                Expanded(
                  child: _buildMaterialStatusIndicator(
                    'Perlu Restok',
                    rawMaterials.where((m) => m.stock <= m.minStock).length,
                    Colors.red,
                  ),
                ),
                Expanded(
                  child: _buildMaterialStatusIndicator(
                    'Expiring Soon',
                    rawMaterials.where((m) => 
                      m.expiryDate.difference(DateTime.now()).inDays <= 30).length,
                    Colors.orange,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      
      const SizedBox(height: 12),
      
      // Daftar bahan baku
      Expanded(
        child: ListView.builder(
          itemCount: sortedMaterials.length,
          itemBuilder: (context, index) {
            final material = sortedMaterials[index];
            final isLowStock = material.stock <= material.minStock;
            final isExpiringSoon = material.expiryDate.difference(DateTime.now()).inDays <= 30;
            final daysToExpiry = material.expiryDate.difference(DateTime.now()).inDays;
            final stockValue = material.price * material.stock;
            
            Color statusColor = const Color(0xFF2E8B57);
            String statusText = 'NORMAL';
            
            if (isLowStock) {
              statusColor = Colors.red;
              statusText = 'RESTOK';
            } else if (isExpiringSoon) {
              statusColor = Colors.orange;
              statusText = 'EXPIRING';
            }
            
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              elevation: (isLowStock || isExpiringSoon) ? 3 : 1,
              color: (isLowStock || isExpiringSoon) 
                ? statusColor.withOpacity(0.05) 
                : null,
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.inventory,
                    color: statusColor,
                    size: 20,
                  ),
                ),
                title: Row(
                  children: [
                    Expanded(
                      child: Text(
                        material.name, 
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    if (isLowStock || isExpiringSoon)
                      Icon(Icons.warning, color: statusColor, size: 16),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(material.supplier),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Text('Stok: ${material.stock}/${material.minStock} ${material.unit}'),
                        const SizedBox(width: 12),
                        Text('Nilai: ${_formatCurrency(stockValue)}'),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Expired: ${_formatDate(material.expiryDate)} ($daysToExpiry hari)',
                      style: TextStyle(
                        fontSize: 12,
                        color: isExpiringSoon ? Colors.orange : Colors.grey,
                      ),
                    ),
                  ],
                ),
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '@ ${_formatCurrency(material.price)}',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(height: 2),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: statusColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        statusText,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    ],
  );
}

Widget _buildMaterialStatusIndicator(String label, int count, Color color) {
  return Column(
    children: [
      Text(
        count.toString(),
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
      Text(
        label,
        style: const TextStyle(fontSize: 11, color: Colors.grey),
        textAlign: TextAlign.center,
      ),
    ],
  );
}

// Tab untuk analisis stok
Widget _buildStockAnalysisTab() {
  // Hitung data analisis
  final totalProductValue = products.fold(0.0, (sum, p) => sum + (p.price * p.stock));
  final totalMaterialValue = rawMaterials.fold(0.0, (sum, m) => sum + (m.price * m.stock));
  final totalInventoryValue = totalProductValue + totalMaterialValue;
  
  // Analisis berdasarkan kategori produk
  Map<String, int> categoryCount = {};
  Map<String, double> categoryValue = {};
  Map<String, int> categoryLowStock = {};
  
  for (var product in products) {
    categoryCount[product.category] = (categoryCount[product.category] ?? 0) + 1;
    categoryValue[product.category] = (categoryValue[product.category] ?? 0) + (product.price * product.stock);
    if (product.stock <= 10) {
      categoryLowStock[product.category] = (categoryLowStock[product.category] ?? 0) + 1;
    }
  }
  
  // Supplier analysis
  Map<String, int> supplierCount = {};
  Map<String, int> supplierLowStock = {};
  
  for (var material in rawMaterials) {
    supplierCount[material.supplier] = (supplierCount[material.supplier] ?? 0) + 1;
    if (material.stock <= material.minStock) {
      supplierLowStock[material.supplier] = (supplierLowStock[material.supplier] ?? 0) + 1;
    }
  }

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Total Inventory Value
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF4CAF50), Color(0xFF8BC34A)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              const Text(
                'Total Nilai Inventori',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                _formatCurrency(totalInventoryValue),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        _formatCurrency(totalProductValue),
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        'Produk',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                  Container(
                    width: 1,
                    height: 30,
                    color: Colors.white30,
                  ),
                  Column(
                    children: [
                      Text(
                        _formatCurrency(totalMaterialValue),
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        'Bahan Baku',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 20),
        
        // Analisis per Kategori
        const Text(
          'Analisis per Kategori Produk',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        
        ...categoryCount.entries.map((entry) {
          final category = entry.key;
          final count = entry.value;
          final value = categoryValue[category] ?? 0;
          final lowStock = categoryLowStock[category] ?? 0;
          final percentage = (value / totalProductValue * 100);
          
          return Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(_getCategoryIcon(category), size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          category,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                      Text(
                        '${percentage.toStringAsFixed(1)}%',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: percentage / 100,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      _getCategoryColor(category),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('$count produk'),
                      Text(_formatCurrency(value)),
                      if (lowStock > 0)
                        Text(
                          '$lowStock stok rendah',
                          style: const TextStyle(color: Colors.orange, fontSize: 12),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }).toList(),
        
        const SizedBox(height: 20),
        
        // Analisis Supplier
        const Text(
          'Analisis per Supplier',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        
        ...supplierCount.entries.map((entry) {
          final supplier = entry.key;
          final count = entry.value;
          final lowStock = supplierLowStock[supplier] ?? 0;
          
          return Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF4682B4).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.business, color: Color(0xFF4682B4), size: 20),
              ),
              title: Text(supplier),
              subtitle: Text('$count bahan baku'),
              trailing: lowStock > 0
                ? Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '$lowStock perlu restok',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  )
                : const Icon(Icons.check_circle, color: Color(0xFF2E8B57)),
            ),
          );
        }).toList(),
        
        const SizedBox(height: 20),
        
        // Rekomendasi
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.blue[200]!),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.lightbulb, color: Colors.blue),
                  SizedBox(width: 8),
                  Text(
                    'Rekomendasi',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              
              if (products.where((p) => p.stock <= 10).isNotEmpty)
                const Text('• Segera restok produk dengan stok rendah'),
              
              if (rawMaterials.where((m) => m.stock <= m.minStock).isNotEmpty)
                const Text('• Perlu restok bahan baku yang sudah mencapai minimum stok'),
              
              if (rawMaterials.where((m) => 
                m.expiryDate.difference(DateTime.now()).inDays <= 30).isNotEmpty)
                const Text('• Prioritaskan penggunaan bahan baku yang akan expired'),
              
              if (categoryValue.isNotEmpty)
                Text('• Kategori dengan nilai tertinggi: ${categoryValue.entries.reduce((a, b) => a.value > b.value ? a : b).key}'),
              
              const Text('• Lakukan audit stok fisik secara berkala'),
            ],
          ),
        ),
        
        const SizedBox(height: 20),
      ],
    ),
  );
}

Color _getCategoryColor(String category) {
  switch (category.toLowerCase()) {
    case 'minuman panas':
      return const Color(0xFFFF9800);
    case 'minuman dingin':
      return const Color(0xFF2196F3);
    case 'makanan':
      return const Color(0xFF4CAF50);
    case 'snack':
      return const Color(0xFF9C27B0);
    default:
      return Colors.grey;
  }
}

// Method untuk export laporan stok
void _exportStockReport() {
  // Simulasi export - dalam implementasi nyata bisa export ke PDF/Excel
  _showSuccessSnackBar('Laporan stok berhasil diekspor!');
}

// Update method _showStockReport() yang sudah ada

  
}

class _showDeleteConfirmation {
  _showDeleteConfirmation(BuildContext context, String s, String t, void Function() param3);
}

