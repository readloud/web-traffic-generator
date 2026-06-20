.class public Lmalitanyo/webtrafficbotpaid/MainActivity;
.super Landroid/app/Activity;
.source "MainActivity.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lmalitanyo/webtrafficbotpaid/MainActivity$100000001;,
        Lmalitanyo/webtrafficbotpaid/MainActivity$100000002;,
        Lmalitanyo/webtrafficbotpaid/MainActivity$100000003;,
        Lmalitanyo/webtrafficbotpaid/MainActivity$100000004;,
        Lmalitanyo/webtrafficbotpaid/MainActivity$100000005;,
        Lmalitanyo/webtrafficbotpaid/MainActivity$100000006;,
        Lmalitanyo/webtrafficbotpaid/MainActivity$100000007;,
        Lmalitanyo/webtrafficbotpaid/MainActivity$100000008;,
        Lmalitanyo/webtrafficbotpaid/MainActivity$100000009;,
        Lmalitanyo/webtrafficbotpaid/MainActivity$100000010;
    }
.end annotation


# instance fields
.field but1:Landroid/widget/Button;

.field but3:Landroid/widget/Button;

.field but4:Landroid/widget/Button;

.field but5:Landroid/widget/Button;

.field but6:Landroid/widget/Button;

.field final context:Landroid/content/Context;

.field ed1:Landroid/widget/EditText;

.field ed2:Landroid/widget/EditText;

.field im01:Landroid/widget/ImageView;

.field in1:Landroid/widget/EditText;

.field in2:Landroid/widget/EditText;

.field nw1:Landroid/widget/Button;

.field nw2:Landroid/widget/Button;

.field nw3:Landroid/widget/Button;

.field nw4:Landroid/widget/Button;

.field nw5:Landroid/widget/Button;

.field private wow:Landroid/webkit/WebView;


# direct methods
.method public constructor <init>()V
    .locals 4

    .prologue
    .line 236
    move-object v0, p0

    move-object v2, v0

    invoke-direct {v2}, Landroid/app/Activity;-><init>()V

    move-object v2, v0

    move-object v3, v0

    iput-object v3, v2, Lmalitanyo/webtrafficbotpaid/MainActivity;->context:Landroid/content/Context;

    return-void
.end method


# virtual methods
.method protected onCreate(Landroid/os/Bundle;)V
    .locals 16
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/os/Bundle;",
            ")V"
        }
    .end annotation

    .annotation runtime Ljava/lang/Override;
    .end annotation

    .prologue
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object v7, v0

    const-string v8, "com.aide.ui"

    invoke-static {v7, v8}, Ladrt/ADRTLogCatReader;->onContext(Landroid/content/Context;Ljava/lang/String;)V

    .line 23
    move-object v7, v0

    move-object v8, v1

    invoke-super {v7, v8}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 24
    move-object v7, v0

    const v8, 0x7f030002

    invoke-virtual {v7, v8}, Lmalitanyo/webtrafficbotpaid/MainActivity;->setContentView(I)V

    .line 25
    move-object v7, v0

    move-object v8, v0

    const v9, 0x7f07000a

    invoke-virtual {v8, v9}, Lmalitanyo/webtrafficbotpaid/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v8

    check-cast v8, Landroid/widget/Button;

    iput-object v8, v7, Lmalitanyo/webtrafficbotpaid/MainActivity;->but1:Landroid/widget/Button;

    .line 26
    move-object v7, v0

    move-object v8, v0

    const v9, 0x7f07000b

    invoke-virtual {v8, v9}, Lmalitanyo/webtrafficbotpaid/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v8

    check-cast v8, Landroid/widget/Button;

    iput-object v8, v7, Lmalitanyo/webtrafficbotpaid/MainActivity;->but3:Landroid/widget/Button;

    .line 27
    move-object v7, v0

    move-object v8, v0

    const v9, 0x7f07000d

    invoke-virtual {v8, v9}, Lmalitanyo/webtrafficbotpaid/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v8

    check-cast v8, Landroid/widget/Button;

    iput-object v8, v7, Lmalitanyo/webtrafficbotpaid/MainActivity;->but4:Landroid/widget/Button;

    .line 28
    move-object v7, v0

    move-object v8, v0

    const v9, 0x7f07000e

    invoke-virtual {v8, v9}, Lmalitanyo/webtrafficbotpaid/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v8

    check-cast v8, Landroid/widget/Button;

    iput-object v8, v7, Lmalitanyo/webtrafficbotpaid/MainActivity;->but5:Landroid/widget/Button;

    .line 29
    move-object v7, v0

    move-object v8, v0

    const v9, 0x7f070005

    invoke-virtual {v8, v9}, Lmalitanyo/webtrafficbotpaid/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v8

    check-cast v8, Landroid/widget/EditText;

    iput-object v8, v7, Lmalitanyo/webtrafficbotpaid/MainActivity;->ed1:Landroid/widget/EditText;

    .line 30
    move-object v7, v0

    move-object v8, v0

    const v9, 0x7f070006

    invoke-virtual {v8, v9}, Lmalitanyo/webtrafficbotpaid/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v8

    check-cast v8, Landroid/widget/EditText;

    iput-object v8, v7, Lmalitanyo/webtrafficbotpaid/MainActivity;->in1:Landroid/widget/EditText;

    .line 31
    move-object v7, v0

    move-object v8, v0

    const v9, 0x7f070007

    invoke-virtual {v8, v9}, Lmalitanyo/webtrafficbotpaid/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v8

    check-cast v8, Landroid/widget/EditText;

    iput-object v8, v7, Lmalitanyo/webtrafficbotpaid/MainActivity;->in2:Landroid/widget/EditText;

    .line 33
    move-object v7, v0

    move-object v8, v0

    const v9, 0x7f07000f

    invoke-virtual {v8, v9}, Lmalitanyo/webtrafficbotpaid/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v8

    check-cast v8, Landroid/widget/Button;

    iput-object v8, v7, Lmalitanyo/webtrafficbotpaid/MainActivity;->nw1:Landroid/widget/Button;

    .line 34
    move-object v7, v0

    move-object v8, v0

    const v9, 0x7f070010

    invoke-virtual {v8, v9}, Lmalitanyo/webtrafficbotpaid/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v8

    check-cast v8, Landroid/widget/Button;

    iput-object v8, v7, Lmalitanyo/webtrafficbotpaid/MainActivity;->nw2:Landroid/widget/Button;

    .line 35
    move-object v7, v0

    move-object v8, v0

    const v9, 0x7f07000c

    invoke-virtual {v8, v9}, Lmalitanyo/webtrafficbotpaid/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v8

    check-cast v8, Landroid/widget/Button;

    iput-object v8, v7, Lmalitanyo/webtrafficbotpaid/MainActivity;->nw3:Landroid/widget/Button;

    .line 37
    move-object v7, v0

    move-object v8, v0

    const v9, 0x7f070004

    invoke-virtual {v8, v9}, Lmalitanyo/webtrafficbotpaid/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v8

    check-cast v8, Landroid/widget/ImageView;

    iput-object v8, v7, Lmalitanyo/webtrafficbotpaid/MainActivity;->im01:Landroid/widget/ImageView;

    .line 38
    move-object v7, v0

    iget-object v7, v7, Lmalitanyo/webtrafficbotpaid/MainActivity;->im01:Landroid/widget/ImageView;

    const/4 v8, 0x0

    invoke-virtual {v7, v8}, Landroid/widget/ImageView;->setVisibility(I)V

    .line 39
    move-object v7, v0

    iget-object v7, v7, Lmalitanyo/webtrafficbotpaid/MainActivity;->but1:Landroid/widget/Button;

    const/16 v8, 0x8

    invoke-virtual {v7, v8}, Landroid/widget/Button;->setVisibility(I)V

    .line 40
    move-object v7, v0

    iget-object v7, v7, Lmalitanyo/webtrafficbotpaid/MainActivity;->but3:Landroid/widget/Button;

    const/16 v8, 0x8

    invoke-virtual {v7, v8}, Landroid/widget/Button;->setVisibility(I)V

    .line 41
    move-object v7, v0

    iget-object v7, v7, Lmalitanyo/webtrafficbotpaid/MainActivity;->but4:Landroid/widget/Button;

    const/16 v8, 0x8

    invoke-virtual {v7, v8}, Landroid/widget/Button;->setVisibility(I)V

    .line 42
    move-object v7, v0

    iget-object v7, v7, Lmalitanyo/webtrafficbotpaid/MainActivity;->but5:Landroid/widget/Button;

    const/16 v8, 0x8

    invoke-virtual {v7, v8}, Landroid/widget/Button;->setVisibility(I)V

    .line 45
    move-object v7, v0

    move-object v8, v0

    const v9, 0x7f070003

    invoke-virtual {v8, v9}, Lmalitanyo/webtrafficbotpaid/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v8

    check-cast v8, Landroid/webkit/WebView;

    iput-object v8, v7, Lmalitanyo/webtrafficbotpaid/MainActivity;->wow:Landroid/webkit/WebView;

    .line 46
    move-object v7, v0

    iget-object v7, v7, Lmalitanyo/webtrafficbotpaid/MainActivity;->wow:Landroid/webkit/WebView;

    invoke-virtual {v7}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v7

    const/4 v8, 0x1

    invoke-virtual {v7, v8}, Landroid/webkit/WebSettings;->setLoadsImagesAutomatically(Z)V

    .line 47
    move-object v7, v0

    iget-object v7, v7, Lmalitanyo/webtrafficbotpaid/MainActivity;->wow:Landroid/webkit/WebView;

    invoke-virtual {v7}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v7

    const/4 v8, 0x1

    invoke-virtual {v7, v8}, Landroid/webkit/WebSettings;->setJavaScriptEnabled(Z)V

    .line 48
    move-object v7, v0

    iget-object v7, v7, Lmalitanyo/webtrafficbotpaid/MainActivity;->wow:Landroid/webkit/WebView;

    invoke-virtual {v7}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v7

    const/4 v8, 0x0

    invoke-virtual {v7, v8}, Landroid/webkit/WebSettings;->setJavaScriptCanOpenWindowsAutomatically(Z)V

    .line 49
    move-object v7, v0

    iget-object v7, v7, Lmalitanyo/webtrafficbotpaid/MainActivity;->wow:Landroid/webkit/WebView;

    invoke-virtual {v7}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v7

    const/4 v8, 0x1

    invoke-virtual {v7, v8}, Landroid/webkit/WebSettings;->setBuiltInZoomControls(Z)V

    .line 50
    move-object v7, v0

    iget-object v7, v7, Lmalitanyo/webtrafficbotpaid/MainActivity;->wow:Landroid/webkit/WebView;

    const/4 v8, 0x0

    invoke-virtual {v7, v8}, Landroid/webkit/WebView;->setBackgroundColor(I)V

    .line 51
    move-object v7, v0

    iget-object v7, v7, Lmalitanyo/webtrafficbotpaid/MainActivity;->wow:Landroid/webkit/WebView;

    invoke-virtual {v7}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v7

    const/4 v8, 0x0

    invoke-virtual {v7, v8}, Landroid/webkit/WebSettings;->setDisplayZoomControls(Z)V

    .line 52
    move-object v7, v0

    iget-object v7, v7, Lmalitanyo/webtrafficbotpaid/MainActivity;->wow:Landroid/webkit/WebView;

    const-string v8, "file:///android_asset/anonymous.html"

    invoke-virtual {v7, v8}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V

    .line 54
    move-object v7, v0

    const/high16 v8, 0x7f070000

    invoke-virtual {v7, v8}, Lmalitanyo/webtrafficbotpaid/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v7

    check-cast v7, Landroid/widget/LinearLayout;

    move-object v3, v7

    .line 55
    move-object v7, v3

    const/16 v8, 0x8

    invoke-virtual {v7, v8}, Landroid/widget/LinearLayout;->setVisibility(I)V

    .line 57
    new-instance v7, Lmalitanyo/webtrafficbotpaid/MainActivity$100000001;

    move-object v15, v7

    move-object v7, v15

    move-object v8, v15

    move-object v9, v0

    const/16 v10, 0x1b58

    int-to-long v10, v10

    const/16 v12, 0x3e8

    int-to-long v12, v12

    move-object v14, v3

    invoke-direct/range {v8 .. v14}, Lmalitanyo/webtrafficbotpaid/MainActivity$100000001;-><init>(Lmalitanyo/webtrafficbotpaid/MainActivity;JJLandroid/widget/LinearLayout;)V

    invoke-virtual {v7}, Lmalitanyo/webtrafficbotpaid/MainActivity$100000001;->start()Landroid/os/CountDownTimer;

    move-result-object v7

    .line 85
    move-object v7, v0

    iget-object v7, v7, Lmalitanyo/webtrafficbotpaid/MainActivity;->in1:Landroid/widget/EditText;

    const-string v8, "5000"

    invoke-virtual {v7, v8}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 86
    move-object v7, v0

    iget-object v7, v7, Lmalitanyo/webtrafficbotpaid/MainActivity;->in2:Landroid/widget/EditText;

    const-string v8, "1000"

    invoke-virtual {v7, v8}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 88
    move-object v7, v0

    const v8, 0x7f070008

    invoke-virtual {v7, v8}, Lmalitanyo/webtrafficbotpaid/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v7

    check-cast v7, Landroid/widget/Switch;

    move-object v4, v7

    .line 89
    move-object v7, v0

    const v8, 0x7f070009

    invoke-virtual {v7, v8}, Lmalitanyo/webtrafficbotpaid/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v7

    check-cast v7, Landroid/widget/Switch;

    move-object v5, v7

    .line 91
    move-object v7, v4

    new-instance v8, Lmalitanyo/webtrafficbotpaid/MainActivity$100000002;

    move-object v15, v8

    move-object v8, v15

    move-object v9, v15

    move-object v10, v0

    move-object v11, v4

    invoke-direct {v9, v10, v11}, Lmalitanyo/webtrafficbotpaid/MainActivity$100000002;-><init>(Lmalitanyo/webtrafficbotpaid/MainActivity;Landroid/widget/Switch;)V

    invoke-virtual {v7, v8}, Landroid/widget/Switch;->setOnCheckedChangeListener(Landroid/widget/CompoundButton$OnCheckedChangeListener;)V

    .line 109
    move-object v7, v5

    new-instance v8, Lmalitanyo/webtrafficbotpaid/MainActivity$100000003;

    move-object v15, v8

    move-object v8, v15

    move-object v9, v15

    move-object v10, v0

    move-object v11, v5

    invoke-direct {v9, v10, v11}, Lmalitanyo/webtrafficbotpaid/MainActivity$100000003;-><init>(Lmalitanyo/webtrafficbotpaid/MainActivity;Landroid/widget/Switch;)V

    invoke-virtual {v7, v8}, Landroid/widget/Switch;->setOnCheckedChangeListener(Landroid/widget/CompoundButton$OnCheckedChangeListener;)V

    .line 130
    move-object v7, v0

    iget-object v7, v7, Lmalitanyo/webtrafficbotpaid/MainActivity;->but1:Landroid/widget/Button;

    new-instance v8, Lmalitanyo/webtrafficbotpaid/MainActivity$100000004;

    move-object v15, v8

    move-object v8, v15

    move-object v9, v15

    move-object v10, v0

    invoke-direct {v9, v10}, Lmalitanyo/webtrafficbotpaid/MainActivity$100000004;-><init>(Lmalitanyo/webtrafficbotpaid/MainActivity;)V

    invoke-virtual {v7, v8}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 168
    move-object v7, v0

    iget-object v7, v7, Lmalitanyo/webtrafficbotpaid/MainActivity;->but3:Landroid/widget/Button;

    new-instance v8, Lmalitanyo/webtrafficbotpaid/MainActivity$100000005;

    move-object v15, v8

    move-object v8, v15

    move-object v9, v15

    move-object v10, v0

    invoke-direct {v9, v10}, Lmalitanyo/webtrafficbotpaid/MainActivity$100000005;-><init>(Lmalitanyo/webtrafficbotpaid/MainActivity;)V

    invoke-virtual {v7, v8}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 179
    move-object v7, v0

    iget-object v7, v7, Lmalitanyo/webtrafficbotpaid/MainActivity;->but4:Landroid/widget/Button;

    new-instance v8, Lmalitanyo/webtrafficbotpaid/MainActivity$100000006;

    move-object v15, v8

    move-object v8, v15

    move-object v9, v15

    move-object v10, v0

    invoke-direct {v9, v10}, Lmalitanyo/webtrafficbotpaid/MainActivity$100000006;-><init>(Lmalitanyo/webtrafficbotpaid/MainActivity;)V

    invoke-virtual {v7, v8}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 195
    move-object v7, v0

    iget-object v7, v7, Lmalitanyo/webtrafficbotpaid/MainActivity;->but5:Landroid/widget/Button;

    new-instance v8, Lmalitanyo/webtrafficbotpaid/MainActivity$100000007;

    move-object v15, v8

    move-object v8, v15

    move-object v9, v15

    move-object v10, v0

    invoke-direct {v9, v10}, Lmalitanyo/webtrafficbotpaid/MainActivity$100000007;-><init>(Lmalitanyo/webtrafficbotpaid/MainActivity;)V

    invoke-virtual {v7, v8}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 207
    move-object v7, v0

    iget-object v7, v7, Lmalitanyo/webtrafficbotpaid/MainActivity;->nw1:Landroid/widget/Button;

    new-instance v8, Lmalitanyo/webtrafficbotpaid/MainActivity$100000008;

    move-object v15, v8

    move-object v8, v15

    move-object v9, v15

    move-object v10, v0

    invoke-direct {v9, v10}, Lmalitanyo/webtrafficbotpaid/MainActivity$100000008;-><init>(Lmalitanyo/webtrafficbotpaid/MainActivity;)V

    invoke-virtual {v7, v8}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 216
    move-object v7, v0

    iget-object v7, v7, Lmalitanyo/webtrafficbotpaid/MainActivity;->nw2:Landroid/widget/Button;

    new-instance v8, Lmalitanyo/webtrafficbotpaid/MainActivity$100000009;

    move-object v15, v8

    move-object v8, v15

    move-object v9, v15

    move-object v10, v0

    invoke-direct {v9, v10}, Lmalitanyo/webtrafficbotpaid/MainActivity$100000009;-><init>(Lmalitanyo/webtrafficbotpaid/MainActivity;)V

    invoke-virtual {v7, v8}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 224
    move-object v7, v0

    iget-object v7, v7, Lmalitanyo/webtrafficbotpaid/MainActivity;->nw3:Landroid/widget/Button;

    new-instance v8, Lmalitanyo/webtrafficbotpaid/MainActivity$100000010;

    move-object v15, v8

    move-object v8, v15

    move-object v9, v15

    move-object v10, v0

    invoke-direct {v9, v10}, Lmalitanyo/webtrafficbotpaid/MainActivity$100000010;-><init>(Lmalitanyo/webtrafficbotpaid/MainActivity;)V

    invoke-virtual {v7, v8}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    return-void
.end method
