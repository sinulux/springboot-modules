package com.springboot.solr.demo.service;

import java.io.IOException;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.List;

import com.springboot.solr.demo.vo.Items;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.solr.client.solrj.SolrServerException;
import org.apache.solr.client.solrj.impl.HttpSolrServer;
import org.apache.solr.client.solrj.response.QueryResponse;
import org.apache.solr.common.SolrDocument;
import org.apache.solr.common.SolrDocumentList;
import org.apache.solr.common.params.ModifiableSolrParams;

public class SolrServiceDemo {
    private final static String url = "http://localhost:8818/solr/collection1";

    public static void main(String[] args) {
        //new SolrServiceDemo().add();
        //new SolrServiceDemo().delete();
        //new SolrServiceDemo().update();
        new SolrServiceDemo().query();
    }

    /**
     * 添加
     */
    public void add() {
        try {
            HttpSolrServer server = getSolrServer();
            List<Items> list = new ArrayList<Items>();
            for (int i = 0; i < 5; i++) {
                Items item = new Items();
                item.setId(i + 1);
                item.setName("item_" + (i + 1));
                item.setPrice(500 * i);
                item.setRelease_time((int) (System.currentTimeMillis() / 1000));
                item.setDeals(10 + i);
                item.setHits(50 * i);
                list.add(item);
            }
            server.addBeans(list);
            server.commit();
            System.out.println("添加完成");
        } catch (SolrServerException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     * 删除
     */
    public void delete() {
        try {
            HttpSolrServer server = getSolrServer();
            server.deleteById("1");
            server.commit();
            System.out.println("删除完成");
        } catch (SolrServerException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     * 修改
     **/
    public void update() {
        try {
            HttpSolrServer server = getSolrServer();
            Items item = new Items();
            item.setId(3);
            item.setName("item_modify");
            item.setPrice(5009);
            item.setRelease_time((int) (System.currentTimeMillis() / 1000));
            item.setDeals(109);
            item.setHits(509);
            server.addBean(item);
            server.commit();
            System.out.println("修改完成");
        } catch (IOException e) {
            e.printStackTrace();
        } catch (SolrServerException e) {
            e.printStackTrace();
        }
    }

    /**
     * 查询
     */
    public void query() {
        try {
            HttpSolrServer server = getSolrServer();
            ModifiableSolrParams params = new ModifiableSolrParams();
            params.set("q", "id:3"); // q表示查询字符串
            params.set("start", 0); // start是开始记录数 分页用
            params.set("rows", 3); // rows是返回记录条数 分页用
            params.set("sort", "price desc");//sort是排序字段 字段名 排序类型
            params.set("fl", "id,name,price,releaseTime,deals,hits"); //fl是 fieldlist缩写，就是需要返回的字段列表，用逗号和空格隔开
            QueryResponse response = null;
            try {
                response = server.query(params);
            } catch (IOException e) {
                e.printStackTrace();
            }
            SolrDocumentList results = response.getResults();
            if (!results.isEmpty()) {
                List<Items> list = toBeanList(results, Items.class);
                for (Items s : list) {
                    System.out.println(s);
                }
            }
            System.out.println("参数查询完成");
        } catch (SolrServerException e) {
            e.printStackTrace();
        }
    }

    /**
     * Solr文档对象转Java对象
     *
     * @param record
     * @param clazz
     * @return Object
     */
    public static Object toBean(SolrDocument record, Class<Object> clazz) {
        Object o = null;
        try {
            o = clazz.newInstance();
        } catch (InstantiationException e) {
            System.out.println("Solr文档对象转Java对象实例化异常:" + e.getMessage());
        } catch (IllegalAccessException e) {
            System.out.println("Solr文档对象转Java对象非法访问异常:" + e.getMessage());
        }
        Field[] fields = clazz.getDeclaredFields();
        for (Field field : fields) {
            // log.warn("------------" + record.toString());
            Object value = record.get(field.getName());
            try {
                if (value != null) {
                    BeanUtils.setProperty(o, field.getName(), value);
                }
            } catch (IllegalAccessException e) {
                System.out.println("Solr文档对象转Java对象方法非法访问异常:" + e.getMessage());
            } catch (InvocationTargetException e) {
                System.out.println("Solr文档对象转Java对象调用目标异常:" + e.getMessage());
            }
        }
        return o;
    }

    public static List toBeanList(SolrDocumentList records, Class clazz) {
        List list = new ArrayList();
        for (SolrDocument record : records) {
            list.add(toBean(record, clazz));
        }
        return list;
    }

    /**
     * solrServer是线程安全的，所以在使用时需要使用单例的模式，减少资源的消耗
     */
    private HttpSolrServer solrServer = null;

    public HttpSolrServer getSolrServer() {
        if (solrServer == null) {
            solrServer = new HttpSolrServer(url);
        }
        return solrServer;
    }
}