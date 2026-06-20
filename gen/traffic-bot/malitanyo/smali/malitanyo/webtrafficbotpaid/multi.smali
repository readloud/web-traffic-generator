.class public Lmalitanyo/webtrafficbotpaid/multi;
.super Landroid/app/Activity;
.source "multi.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lmalitanyo/webtrafficbotpaid/multi$100000001;,
        Lmalitanyo/webtrafficbotpaid/multi$100000003;,
        Lmalitanyo/webtrafficbotpaid/multi$100000005;,
        Lmalitanyo/webtrafficbotpaid/multi$100000007;,
        Lmalitanyo/webtrafficbotpaid/multi$100000010;,
        Lmalitanyo/webtrafficbotpaid/multi$MyWebViewClient;,
        Lmalitanyo/webtrafficbotpaid/multi$MyWebViewClient02;,
        Lmalitanyo/webtrafficbotpaid/multi$MyWebViewClient03;,
        Lmalitanyo/webtrafficbotpaid/multi$MyWebViewClient04;
    }
.end annotation


# instance fields
.field private btn:Landroid/widget/Button;

.field private btn2:Landroid/widget/Button;

.field private btn3:Landroid/widget/Button;

.field private btn4:Landroid/widget/Button;

.field private btn5:Landroid/widget/Button;

.field final context:Landroid/content/Context;

.field counter:I

.field counterlimit:I

.field ed1:Landroid/widget/EditText;

.field private inf:Landroid/widget/Button;

.field infb:Landroid/widget/TextView;

.field itext:Landroid/widget/TextView;

.field lgo:Landroid/widget/ImageView;

.field lmt:Landroid/widget/TextView;

.field logx:Landroid/widget/TextView;

.field private progress:Landroid/widget/ProgressBar;

.field private progress2:Landroid/widget/ProgressBar;

.field private progress3:Landroid/widget/ProgressBar;

.field private progress4:Landroid/widget/ProgressBar;

.field rn0:Landroid/widget/TextView;

.field title:Landroid/widget/TextView;

.field tx1:Landroid/widget/TextView;

.field tx2:Landroid/widget/TextView;

.field tx3:Landroid/widget/TextView;

.field tx4:Landroid/widget/TextView;

.field tx5:Landroid/widget/TextView;

.field txc:Landroid/widget/TextView;

.field txon:Landroid/widget/TextView;

.field private web2:Landroid/webkit/WebView;

.field private web3:Landroid/webkit/WebView;

.field private web4:Landroid/webkit/WebView;

.field private webView:Landroid/webkit/WebView;

.field private webn:Landroid/webkit/WebView;

.field private webs:Landroid/webkit/WebView;

.field wew:Landroid/widget/TextView;


# direct methods
.method public constructor <init>()V
    .locals 4

    .prologue
    .line 362
    move-object v0, p0

    move-object v2, v0

    invoke-direct {v2}, Landroid/app/Activity;-><init>()V

    move-object v2, v0

    const/4 v3, 0x0

    iput v3, v2, Lmalitanyo/webtrafficbotpaid/multi;->counter:I

    move-object v2, v0

    const/4 v3, 0x0

    iput v3, v2, Lmalitanyo/webtrafficbotpaid/multi;->counterlimit:I

    move-object v2, v0

    move-object v3, v0

    iput-object v3, v2, Lmalitanyo/webtrafficbotpaid/multi;->context:Landroid/content/Context;

    return-void
.end method

.method static synthetic access$L1000000(Lmalitanyo/webtrafficbotpaid/multi;)Landroid/webkit/WebView;
    .locals 4

    move-object v0, p0

    move-object v3, v0

    iget-object v3, v3, Lmalitanyo/webtrafficbotpaid/multi;->webView:Landroid/webkit/WebView;

    move-object v0, v3

    return-object v0
.end method

.method static synthetic access$L1000003(Lmalitanyo/webtrafficbotpaid/multi;)Landroid/webkit/WebView;
    .locals 4

    move-object v0, p0

    move-object v3, v0

    iget-object v3, v3, Lmalitanyo/webtrafficbotpaid/multi;->web2:Landroid/webkit/WebView;

    move-object v0, v3

    return-object v0
.end method

.method static synthetic access$L1000004(Lmalitanyo/webtrafficbotpaid/multi;)Landroid/webkit/WebView;
    .locals 4

    move-object v0, p0

    move-object v3, v0

    iget-object v3, v3, Lmalitanyo/webtrafficbotpaid/multi;->web3:Landroid/webkit/WebView;

    move-object v0, v3

    return-object v0
.end method

.method static synthetic access$L1000005(Lmalitanyo/webtrafficbotpaid/multi;)Landroid/webkit/WebView;
    .locals 4

    move-object v0, p0

    move-object v3, v0

    iget-object v3, v3, Lmalitanyo/webtrafficbotpaid/multi;->web4:Landroid/webkit/WebView;

    move-object v0, v3

    return-object v0
.end method

.method static synthetic access$S1000000(Lmalitanyo/webtrafficbotpaid/multi;Landroid/webkit/WebView;)V
    .locals 6

    move-object v0, p0

    move-object v1, p1

    move-object v4, v0

    move-object v5, v1

    iput-object v5, v4, Lmalitanyo/webtrafficbotpaid/multi;->webView:Landroid/webkit/WebView;

    return-void
.end method

.method static synthetic access$S1000003(Lmalitanyo/webtrafficbotpaid/multi;Landroid/webkit/WebView;)V
    .locals 6

    move-object v0, p0

    move-object v1, p1

    move-object v4, v0

    move-object v5, v1

    iput-object v5, v4, Lmalitanyo/webtrafficbotpaid/multi;->web2:Landroid/webkit/WebView;

    return-void
.end method

.method static synthetic access$S1000004(Lmalitanyo/webtrafficbotpaid/multi;Landroid/webkit/WebView;)V
    .locals 6

    move-object v0, p0

    move-object v1, p1

    move-object v4, v0

    move-object v5, v1

    iput-object v5, v4, Lmalitanyo/webtrafficbotpaid/multi;->web3:Landroid/webkit/WebView;

    return-void
.end method

.method static synthetic access$S1000005(Lmalitanyo/webtrafficbotpaid/multi;Landroid/webkit/WebView;)V
    .locals 6

    move-object v0, p0

    move-object v1, p1

    move-object v4, v0

    move-object v5, v1

    iput-object v5, v4, Lmalitanyo/webtrafficbotpaid/multi;->web4:Landroid/webkit/WebView;

    return-void
.end method

.method public static setLPreViewWebViewProxy(Landroid/content/Context;Ljava/lang/String;I)V
    .locals 34
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/lang/String;",
            "I)V"
        }
    .end annotation

    .prologue
    .line 337
    move-object/from16 v1, p0

    move-object/from16 v2, p1

    move/from16 v3, p2

    const-string v24, "http.proxyHost"

    move-object/from16 v25, v2

    invoke-static/range {v24 .. v25}, Ljava/lang/System;->setProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v24

    .line 338
    const-string v24, "http.proxyPort"

    new-instance v25, Ljava/lang/StringBuffer;

    move-object/from16 v33, v25

    move-object/from16 v25, v33

    move-object/from16 v26, v33

    invoke-direct/range {v26 .. v26}, Ljava/lang/StringBuffer;-><init>()V

    move/from16 v26, v3

    invoke-virtual/range {v25 .. v26}, Ljava/lang/StringBuffer;->append(I)Ljava/lang/StringBuffer;

    move-result-object v25

    const-string v26, ""

    invoke-virtual/range {v25 .. v26}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v25

    invoke-virtual/range {v25 .. v25}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v25

    invoke-static/range {v24 .. v25}, Ljava/lang/System;->setProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v24

    .line 340
    move-object/from16 v24, v1

    :try_start_0
    invoke-virtual/range {v24 .. v24}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v24

    move-object/from16 v5, v24

    .line 341
    const-string v24, "android.app.Application"

    invoke-static/range {v24 .. v24}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v24

    move-object/from16 v6, v24

    .line 342
    move-object/from16 v24, v6

    const-string v25, "mLoadedApk"

    invoke-virtual/range {v24 .. v25}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v24

    move-object/from16 v7, v24

    .line 343
    move-object/from16 v24, v7

    const/16 v25, 0x1

    invoke-virtual/range {v24 .. v25}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 344
    move-object/from16 v24, v7

    move-object/from16 v25, v5

    invoke-virtual/range {v24 .. v25}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v24

    move-object/from16 v8, v24

    .line 345
    const-string v24, "android.app.LoadedApk"

    invoke-static/range {v24 .. v24}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v24

    move-object/from16 v9, v24

    .line 346
    move-object/from16 v24, v9

    const-string v25, "mReceivers"

    invoke-virtual/range {v24 .. v25}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v24

    move-object/from16 v10, v24

    .line 347
    move-object/from16 v24, v10

    const/16 v25, 0x1

    invoke-virtual/range {v24 .. v25}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 348
    move-object/from16 v24, v10

    move-object/from16 v25, v8

    invoke-virtual/range {v24 .. v25}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v24

    check-cast v24, Landroid/util/ArrayMap;

    move-object/from16 v11, v24

    .line 349
    move-object/from16 v24, v11

    invoke-virtual/range {v24 .. v24}, Landroid/util/ArrayMap;->values()Ljava/util/Collection;

    move-result-object v24

    check-cast v24, Ljava/util/Collection;

    invoke-interface/range {v24 .. v24}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v24

    move-object/from16 v12, v24

    .line 355
    :cond_0
    move-object/from16 v24, v12

    invoke-interface/range {v24 .. v24}, Ljava/util/Iterator;->hasNext()Z

    move-result v24

    if-nez v24, :cond_1

    .line 360
    :goto_0
    return-void

    .line 349
    :cond_1
    move-object/from16 v24, v12

    invoke-interface/range {v24 .. v24}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v24

    check-cast v24, Ljava/lang/Object;

    move-object/from16 v14, v24

    .line 350
    move-object/from16 v24, v14

    check-cast v24, Landroid/util/ArrayMap;

    invoke-virtual/range {v24 .. v24}, Landroid/util/ArrayMap;->keySet()Ljava/util/Set;

    move-result-object v24

    check-cast v24, Ljava/util/Collection;

    invoke-interface/range {v24 .. v24}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v24

    move-object/from16 v15, v24

    .line 355
    :cond_2
    :goto_1
    move-object/from16 v24, v15

    invoke-interface/range {v24 .. v24}, Ljava/util/Iterator;->hasNext()Z

    move-result v24

    if-eqz v24, :cond_0

    .line 350
    move-object/from16 v24, v15

    invoke-interface/range {v24 .. v24}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v24

    check-cast v24, Ljava/lang/Object;

    move-object/from16 v17, v24

    .line 351
    move-object/from16 v24, v17

    invoke-virtual/range {v24 .. v24}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v24

    move-object/from16 v18, v24

    .line 352
    move-object/from16 v24, v18

    invoke-virtual/range {v24 .. v24}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v24

    const-string v25, "ProxyChangeListener"

    invoke-virtual/range {v24 .. v25}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v24

    if-eqz v24, :cond_2

    .line 353
    move-object/from16 v24, v18

    const-string v25, "onReceive"

    const/16 v26, 0x2

    move/from16 v0, v26

    new-array v0, v0, [Ljava/lang/Class;

    move-object/from16 v26, v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    move-object/from16 v33, v26

    move-object/from16 v26, v33

    move-object/from16 v27, v33

    const/16 v28, 0x0

    :try_start_1
    const-string v29, "android.content.Context"

    invoke-static/range {v29 .. v29}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;
    :try_end_1
    .catch Ljava/lang/ClassNotFoundException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    move-result-object v29

    :try_start_2
    aput-object v29, v27, v28
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_1

    move-object/from16 v33, v26

    move-object/from16 v26, v33

    move-object/from16 v27, v33

    const/16 v28, 0x1

    :try_start_3
    const-string v29, "android.content.Intent"

    invoke-static/range {v29 .. v29}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;
    :try_end_3
    .catch Ljava/lang/ClassNotFoundException; {:try_start_3 .. :try_end_3} :catch_2
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_1

    move-result-object v29

    :try_start_4
    aput-object v29, v27, v28

    invoke-virtual/range {v24 .. v26}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v24

    move-object/from16 v19, v24

    .line 354
    new-instance v24, Landroid/content/Intent;

    move-object/from16 v33, v24

    move-object/from16 v24, v33

    move-object/from16 v25, v33

    const-string v26, "android.intent.action.PROXY_CHANGE"

    invoke-direct/range {v25 .. v26}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    move-object/from16 v22, v24

    .line 355
    move-object/from16 v24, v19

    move-object/from16 v25, v17

    const/16 v26, 0x2

    move/from16 v0, v26

    new-array v0, v0, [Ljava/lang/Object;

    move-object/from16 v26, v0

    move-object/from16 v33, v26

    move-object/from16 v26, v33

    move-object/from16 v27, v33

    const/16 v28, 0x0

    move-object/from16 v29, v5

    aput-object v29, v27, v28

    move-object/from16 v33, v26

    move-object/from16 v26, v33

    move-object/from16 v27, v33

    const/16 v28, 0x1

    move-object/from16 v29, v22

    aput-object v29, v27, v28

    invoke-virtual/range {v24 .. v26}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v24

    goto/16 :goto_1

    .line 353
    :catch_0
    move-exception v24

    move-object/from16 v20, v24

    new-instance v24, Ljava/lang/NoClassDefFoundError;

    move-object/from16 v33, v24

    move-object/from16 v24, v33

    move-object/from16 v25, v33

    move-object/from16 v26, v20

    invoke-virtual/range {v26 .. v26}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v26

    invoke-direct/range {v25 .. v26}, Ljava/lang/NoClassDefFoundError;-><init>(Ljava/lang/String;)V

    throw v24
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_1

    .line 355
    :catch_1
    move-exception v24

    move-object/from16 v5, v24

    .line 360
    move-object/from16 v24, v5

    invoke-virtual/range {v24 .. v24}, Ljava/lang/Exception;->printStackTrace()V

    goto/16 :goto_0

    .line 353
    :catch_2
    move-exception v24

    move-object/from16 v21, v24

    :try_start_5
    new-instance v24, Ljava/lang/NoClassDefFoundError;

    move-object/from16 v33, v24

    move-object/from16 v24, v33

    move-object/from16 v25, v33

    move-object/from16 v26, v21

    invoke-virtual/range {v26 .. v26}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v26

    invoke-direct/range {v25 .. v26}, Ljava/lang/NoClassDefFoundError;-><init>(Ljava/lang/String;)V

    throw v24
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_1
.end method


# virtual methods
.method protected onCreate(Landroid/os/Bundle;)V
    .locals 18
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

    move-object v9, v0

    const-string v10, "com.aide.ui"

    invoke-static {v9, v10}, Ladrt/ADRTLogCatReader;->onContext(Landroid/content/Context;Ljava/lang/String;)V

    .line 34
    move-object v9, v0

    move-object v10, v1

    invoke-super {v9, v10}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 35
    move-object v9, v0

    const v10, 0x7f030004

    invoke-virtual {v9, v10}, Lmalitanyo/webtrafficbotpaid/multi;->setContentView(I)V

    .line 36
    move-object v9, v0

    move-object v10, v0

    const v11, 0x7f07001f

    invoke-virtual {v10, v11}, Lmalitanyo/webtrafficbotpaid/multi;->findViewById(I)Landroid/view/View;

    move-result-object v10

    check-cast v10, Landroid/webkit/WebView;

    iput-object v10, v9, Lmalitanyo/webtrafficbotpaid/multi;->web2:Landroid/webkit/WebView;

    .line 37
    move-object v9, v0

    move-object v10, v0

    const v11, 0x7f070020

    invoke-virtual {v10, v11}, Lmalitanyo/webtrafficbotpaid/multi;->findViewById(I)Landroid/view/View;

    move-result-object v10

    check-cast v10, Landroid/webkit/WebView;

    iput-object v10, v9, Lmalitanyo/webtrafficbotpaid/multi;->web3:Landroid/webkit/WebView;

    .line 38
    move-object v9, v0

    move-object v10, v0

    const v11, 0x7f070021

    invoke-virtual {v10, v11}, Lmalitanyo/webtrafficbotpaid/multi;->findViewById(I)Landroid/view/View;

    move-result-object v10

    check-cast v10, Landroid/webkit/WebView;

    iput-object v10, v9, Lmalitanyo/webtrafficbotpaid/multi;->web4:Landroid/webkit/WebView;

    .line 39
    move-object v9, v0

    move-object v10, v0

    const v11, 0x7f070012

    invoke-virtual {v10, v11}, Lmalitanyo/webtrafficbotpaid/multi;->findViewById(I)Landroid/view/View;

    move-result-object v10

    check-cast v10, Landroid/webkit/WebView;

    iput-object v10, v9, Lmalitanyo/webtrafficbotpaid/multi;->webn:Landroid/webkit/WebView;

    .line 40
    move-object v9, v0

    move-object v10, v0

    const v11, 0x7f07001e

    invoke-virtual {v10, v11}, Lmalitanyo/webtrafficbotpaid/multi;->findViewById(I)Landroid/view/View;

    move-result-object v10

    check-cast v10, Landroid/webkit/WebView;

    iput-object v10, v9, Lmalitanyo/webtrafficbotpaid/multi;->webView:Landroid/webkit/WebView;

    .line 41
    move-object v9, v0

    move-object v10, v0

    const v11, 0x7f07001d

    invoke-virtual {v10, v11}, Lmalitanyo/webtrafficbotpaid/multi;->findViewById(I)Landroid/view/View;

    move-result-object v10

    check-cast v10, Landroid/webkit/WebView;

    iput-object v10, v9, Lmalitanyo/webtrafficbotpaid/multi;->webs:Landroid/webkit/WebView;

    .line 42
    move-object v9, v0

    move-object v10, v0

    const v11, 0x7f070013

    invoke-virtual {v10, v11}, Lmalitanyo/webtrafficbotpaid/multi;->findViewById(I)Landroid/view/View;

    move-result-object v10

    check-cast v10, Landroid/widget/TextView;

    iput-object v10, v9, Lmalitanyo/webtrafficbotpaid/multi;->tx1:Landroid/widget/TextView;

    .line 43
    move-object v9, v0

    move-object v10, v0

    const v11, 0x7f070016

    invoke-virtual {v10, v11}, Lmalitanyo/webtrafficbotpaid/multi;->findViewById(I)Landroid/view/View;

    move-result-object v10

    check-cast v10, Landroid/widget/TextView;

    iput-object v10, v9, Lmalitanyo/webtrafficbotpaid/multi;->tx4:Landroid/widget/TextView;

    .line 44
    move-object v9, v0

    move-object v10, v0

    const v11, 0x7f070014

    invoke-virtual {v10, v11}, Lmalitanyo/webtrafficbotpaid/multi;->findViewById(I)Landroid/view/View;

    move-result-object v10

    check-cast v10, Landroid/widget/TextView;

    iput-object v10, v9, Lmalitanyo/webtrafficbotpaid/multi;->tx2:Landroid/widget/TextView;

    .line 45
    move-object v9, v0

    move-object v10, v0

    const v11, 0x7f070015

    invoke-virtual {v10, v11}, Lmalitanyo/webtrafficbotpaid/multi;->findViewById(I)Landroid/view/View;

    move-result-object v10

    check-cast v10, Landroid/widget/TextView;

    iput-object v10, v9, Lmalitanyo/webtrafficbotpaid/multi;->tx3:Landroid/widget/TextView;

    .line 46
    move-object v9, v0

    move-object v10, v0

    const v11, 0x7f07001c

    invoke-virtual {v10, v11}, Lmalitanyo/webtrafficbotpaid/multi;->findViewById(I)Landroid/view/View;

    move-result-object v10

    check-cast v10, Landroid/widget/Button;

    iput-object v10, v9, Lmalitanyo/webtrafficbotpaid/multi;->btn:Landroid/widget/Button;

    .line 47
    move-object v9, v0

    move-object v10, v0

    const v11, 0x7f070018

    invoke-virtual {v10, v11}, Lmalitanyo/webtrafficbotpaid/multi;->findViewById(I)Landroid/view/View;

    move-result-object v10

    check-cast v10, Landroid/widget/ProgressBar;

    iput-object v10, v9, Lmalitanyo/webtrafficbotpaid/multi;->progress:Landroid/widget/ProgressBar;

    .line 48
    move-object v9, v0

    iget-object v9, v9, Lmalitanyo/webtrafficbotpaid/multi;->progress:Landroid/widget/ProgressBar;

    const/16 v10, 0x64

    invoke-virtual {v9, v10}, Landroid/widget/ProgressBar;->setMax(I)V

    .line 50
    move-object v9, v0

    move-object v10, v0

    const v11, 0x7f070019

    invoke-virtual {v10, v11}, Lmalitanyo/webtrafficbotpaid/multi;->findViewById(I)Landroid/view/View;

    move-result-object v10

    check-cast v10, Landroid/widget/ProgressBar;

    iput-object v10, v9, Lmalitanyo/webtrafficbotpaid/multi;->progress2:Landroid/widget/ProgressBar;

    .line 51
    move-object v9, v0

    iget-object v9, v9, Lmalitanyo/webtrafficbotpaid/multi;->progress2:Landroid/widget/ProgressBar;

    const/16 v10, 0x64

    invoke-virtual {v9, v10}, Landroid/widget/ProgressBar;->setMax(I)V

    .line 53
    move-object v9, v0

    move-object v10, v0

    const v11, 0x7f07001a

    invoke-virtual {v10, v11}, Lmalitanyo/webtrafficbotpaid/multi;->findViewById(I)Landroid/view/View;

    move-result-object v10

    check-cast v10, Landroid/widget/ProgressBar;

    iput-object v10, v9, Lmalitanyo/webtrafficbotpaid/multi;->progress3:Landroid/widget/ProgressBar;

    .line 54
    move-object v9, v0

    iget-object v9, v9, Lmalitanyo/webtrafficbotpaid/multi;->progress3:Landroid/widget/ProgressBar;

    const/16 v10, 0x64

    invoke-virtual {v9, v10}, Landroid/widget/ProgressBar;->setMax(I)V

    .line 56
    move-object v9, v0

    move-object v10, v0

    const v11, 0x7f07001b

    invoke-virtual {v10, v11}, Lmalitanyo/webtrafficbotpaid/multi;->findViewById(I)Landroid/view/View;

    move-result-object v10

    check-cast v10, Landroid/widget/ProgressBar;

    iput-object v10, v9, Lmalitanyo/webtrafficbotpaid/multi;->progress4:Landroid/widget/ProgressBar;

    .line 57
    move-object v9, v0

    iget-object v9, v9, Lmalitanyo/webtrafficbotpaid/multi;->progress4:Landroid/widget/ProgressBar;

    const/16 v10, 0x64

    invoke-virtual {v9, v10}, Landroid/widget/ProgressBar;->setMax(I)V

    .line 59
    new-instance v9, Ljava/util/Timer;

    move-object/from16 v17, v9

    move-object/from16 v9, v17

    move-object/from16 v10, v17

    invoke-direct {v10}, Ljava/util/Timer;-><init>()V

    move-object v3, v9

    .line 60
    move-object v9, v3

    new-instance v10, Lmalitanyo/webtrafficbotpaid/multi$100000001;

    move-object/from16 v17, v10

    move-object/from16 v10, v17

    move-object/from16 v11, v17

    move-object v12, v0

    invoke-direct {v11, v12}, Lmalitanyo/webtrafficbotpaid/multi$100000001;-><init>(Lmalitanyo/webtrafficbotpaid/multi;)V

    const/4 v11, 0x0

    int-to-long v11, v11

    const/16 v13, 0x1388

    int-to-long v13, v13

    invoke-virtual/range {v9 .. v14}, Ljava/util/Timer;->scheduleAtFixedRate(Ljava/util/TimerTask;JJ)V

    .line 101
    new-instance v9, Ljava/util/Timer;

    move-object/from16 v17, v9

    move-object/from16 v9, v17

    move-object/from16 v10, v17

    invoke-direct {v10}, Ljava/util/Timer;-><init>()V

    move-object v4, v9

    .line 102
    move-object v9, v4

    new-instance v10, Lmalitanyo/webtrafficbotpaid/multi$100000003;

    move-object/from16 v17, v10

    move-object/from16 v10, v17

    move-object/from16 v11, v17

    move-object v12, v0

    invoke-direct {v11, v12}, Lmalitanyo/webtrafficbotpaid/multi$100000003;-><init>(Lmalitanyo/webtrafficbotpaid/multi;)V

    const/4 v11, 0x0

    int-to-long v11, v11

    const/16 v13, 0x1388

    int-to-long v13, v13

    invoke-virtual/range {v9 .. v14}, Ljava/util/Timer;->scheduleAtFixedRate(Ljava/util/TimerTask;JJ)V

    .line 141
    new-instance v9, Ljava/util/Timer;

    move-object/from16 v17, v9

    move-object/from16 v9, v17

    move-object/from16 v10, v17

    invoke-direct {v10}, Ljava/util/Timer;-><init>()V

    move-object v5, v9

    .line 142
    move-object v9, v5

    new-instance v10, Lmalitanyo/webtrafficbotpaid/multi$100000005;

    move-object/from16 v17, v10

    move-object/from16 v10, v17

    move-object/from16 v11, v17

    move-object v12, v0

    invoke-direct {v11, v12}, Lmalitanyo/webtrafficbotpaid/multi$100000005;-><init>(Lmalitanyo/webtrafficbotpaid/multi;)V

    const/4 v11, 0x0

    int-to-long v11, v11

    const/16 v13, 0xfa0

    int-to-long v13, v13

    invoke-virtual/range {v9 .. v14}, Ljava/util/Timer;->scheduleAtFixedRate(Ljava/util/TimerTask;JJ)V

    .line 182
    new-instance v9, Ljava/util/Timer;

    move-object/from16 v17, v9

    move-object/from16 v9, v17

    move-object/from16 v10, v17

    invoke-direct {v10}, Ljava/util/Timer;-><init>()V

    move-object v6, v9

    .line 183
    move-object v9, v6

    new-instance v10, Lmalitanyo/webtrafficbotpaid/multi$100000007;

    move-object/from16 v17, v10

    move-object/from16 v10, v17

    move-object/from16 v11, v17

    move-object v12, v0

    invoke-direct {v11, v12}, Lmalitanyo/webtrafficbotpaid/multi$100000007;-><init>(Lmalitanyo/webtrafficbotpaid/multi;)V

    const/4 v11, 0x0

    int-to-long v11, v11

    const/16 v13, 0x1770

    int-to-long v13, v13

    invoke-virtual/range {v9 .. v14}, Ljava/util/Timer;->scheduleAtFixedRate(Ljava/util/TimerTask;JJ)V

    .line 223
    move-object v9, v0

    iget-object v9, v9, Lmalitanyo/webtrafficbotpaid/multi;->btn:Landroid/widget/Button;

    new-instance v10, Lmalitanyo/webtrafficbotpaid/multi$100000010;

    move-object/from16 v17, v10

    move-object/from16 v10, v17

    move-object/from16 v11, v17

    move-object v12, v0

    move-object v13, v3

    move-object v14, v4

    move-object v15, v5

    move-object/from16 v16, v6

    invoke-direct/range {v11 .. v16}, Lmalitanyo/webtrafficbotpaid/multi$100000010;-><init>(Lmalitanyo/webtrafficbotpaid/multi;Ljava/util/Timer;Ljava/util/Timer;Ljava/util/Timer;Ljava/util/Timer;)V

    invoke-virtual {v9, v10}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 252
    move-object v9, v0

    invoke-virtual {v9}, Lmalitanyo/webtrafficbotpaid/multi;->getIntent()Landroid/content/Intent;

    move-result-object v9

    const-string v10, "URL"

    invoke-virtual {v9, v10}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    move-object v7, v9

    .line 253
    move-object v9, v0

    iget-object v9, v9, Lmalitanyo/webtrafficbotpaid/multi;->webs:Landroid/webkit/WebView;

    invoke-virtual {v9}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v9

    const/4 v10, 0x1

    invoke-virtual {v9, v10}, Landroid/webkit/WebSettings;->setLoadsImagesAutomatically(Z)V

    .line 254
    move-object v9, v0

    iget-object v9, v9, Lmalitanyo/webtrafficbotpaid/multi;->webs:Landroid/webkit/WebView;

    invoke-virtual {v9}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v9

    const/4 v10, 0x1

    invoke-virtual {v9, v10}, Landroid/webkit/WebSettings;->setJavaScriptEnabled(Z)V

    .line 255
    move-object v9, v0

    iget-object v9, v9, Lmalitanyo/webtrafficbotpaid/multi;->webs:Landroid/webkit/WebView;

    invoke-virtual {v9}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v9

    const/4 v10, 0x1

    invoke-virtual {v9, v10}, Landroid/webkit/WebSettings;->setBuiltInZoomControls(Z)V

    .line 256
    move-object v9, v0

    iget-object v9, v9, Lmalitanyo/webtrafficbotpaid/multi;->webs:Landroid/webkit/WebView;

    invoke-virtual {v9}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v9

    const/4 v10, 0x0

    invoke-virtual {v9, v10}, Landroid/webkit/WebSettings;->setDisplayZoomControls(Z)V

    .line 257
    move-object v9, v0

    iget-object v9, v9, Lmalitanyo/webtrafficbotpaid/multi;->webs:Landroid/webkit/WebView;

    const/4 v10, -0x1

    invoke-virtual {v9, v10}, Landroid/webkit/WebView;->setBackgroundColor(I)V

    .line 258
    move-object v9, v0

    iget-object v9, v9, Lmalitanyo/webtrafficbotpaid/multi;->webs:Landroid/webkit/WebView;

    move-object v10, v7

    invoke-virtual {v9, v10}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V

    .line 260
    move-object v9, v0

    iget-object v9, v9, Lmalitanyo/webtrafficbotpaid/multi;->webn:Landroid/webkit/WebView;

    invoke-virtual {v9}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v9

    const/4 v10, 0x1

    invoke-virtual {v9, v10}, Landroid/webkit/WebSettings;->setLoadsImagesAutomatically(Z)V

    .line 261
    move-object v9, v0

    iget-object v9, v9, Lmalitanyo/webtrafficbotpaid/multi;->webn:Landroid/webkit/WebView;

    invoke-virtual {v9}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v9

    const/4 v10, 0x1

    invoke-virtual {v9, v10}, Landroid/webkit/WebSettings;->setJavaScriptEnabled(Z)V

    .line 262
    move-object v9, v0

    iget-object v9, v9, Lmalitanyo/webtrafficbotpaid/multi;->webn:Landroid/webkit/WebView;

    invoke-virtual {v9}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v9

    const/4 v10, 0x1

    invoke-virtual {v9, v10}, Landroid/webkit/WebSettings;->setBuiltInZoomControls(Z)V

    .line 263
    move-object v9, v0

    iget-object v9, v9, Lmalitanyo/webtrafficbotpaid/multi;->webn:Landroid/webkit/WebView;

    invoke-virtual {v9}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v9

    const/4 v10, 0x0

    invoke-virtual {v9, v10}, Landroid/webkit/WebSettings;->setDisplayZoomControls(Z)V

    .line 264
    move-object v9, v0

    iget-object v9, v9, Lmalitanyo/webtrafficbotpaid/multi;->webn:Landroid/webkit/WebView;

    const/4 v10, 0x0

    invoke-virtual {v9, v10}, Landroid/webkit/WebView;->setBackgroundColor(I)V

    .line 265
    move-object v9, v0

    iget-object v9, v9, Lmalitanyo/webtrafficbotpaid/multi;->webn:Landroid/webkit/WebView;

    const-string v10, "file:///android_asset/anonymous.html"

    invoke-virtual {v9, v10}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V

    return-void
.end method

.method public onKeyDown(ILandroid/view/KeyEvent;)Z
    .locals 10
    .annotation runtime Ljava/lang/Override;
    .end annotation

    .prologue
    .line 328
    move-object v0, p0

    move v1, p1

    move-object v2, p2

    move v6, v1

    const/4 v7, 0x4

    if-ne v6, v7, :cond_0

    .line 329
    new-instance v6, Landroid/app/AlertDialog$Builder;

    move-object v9, v6

    move-object v6, v9

    move-object v7, v9

    move-object v8, v0

    invoke-direct {v7, v8}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    move-object v4, v6

    .line 330
    move-object v6, v4

    const v7, 0x7f050001

    invoke-virtual {v6, v7}, Landroid/app/AlertDialog$Builder;->setMessage(I)Landroid/app/AlertDialog$Builder;

    move-result-object v6

    .line 331
    move-object v6, v4

    invoke-virtual {v6}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    move-result-object v6

    .line 333
    :cond_0
    move-object v6, v0

    move v7, v1

    move-object v8, v2

    invoke-super {v6, v7, v8}, Landroid/app/Activity;->onKeyDown(ILandroid/view/KeyEvent;)Z

    move-result v6

    move v0, v6

    return v0
.end method

.method public setValue(I)V
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I)V"
        }
    .end annotation

    .prologue
    .line 282
    move-object v0, p0

    move v1, p1

    move-object v3, v0

    iget-object v3, v3, Lmalitanyo/webtrafficbotpaid/multi;->progress:Landroid/widget/ProgressBar;

    move v4, v1

    invoke-virtual {v3, v4}, Landroid/widget/ProgressBar;->setProgress(I)V

    return-void
.end method

.method public setValue04(I)V
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I)V"
        }
    .end annotation

    .prologue
    .line 321
    move-object v0, p0

    move v1, p1

    move-object v3, v0

    iget-object v3, v3, Lmalitanyo/webtrafficbotpaid/multi;->progress4:Landroid/widget/ProgressBar;

    move v4, v1

    invoke-virtual {v3, v4}, Landroid/widget/ProgressBar;->setProgress(I)V

    return-void
.end method

.method public setValue2(I)V
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I)V"
        }
    .end annotation

    .prologue
    .line 294
    move-object v0, p0

    move v1, p1

    move-object v3, v0

    iget-object v3, v3, Lmalitanyo/webtrafficbotpaid/multi;->progress2:Landroid/widget/ProgressBar;

    move v4, v1

    invoke-virtual {v3, v4}, Landroid/widget/ProgressBar;->setProgress(I)V

    return-void
.end method

.method public setValue3(I)V
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I)V"
        }
    .end annotation

    .prologue
    .line 306
    move-object v0, p0

    move v1, p1

    move-object v3, v0

    iget-object v3, v3, Lmalitanyo/webtrafficbotpaid/multi;->progress3:Landroid/widget/ProgressBar;

    move v4, v1

    invoke-virtual {v3, v4}, Landroid/widget/ProgressBar;->setProgress(I)V

    return-void
.end method
